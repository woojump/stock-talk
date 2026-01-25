import os
import pymysql
from fastapi import APIRouter, HTTPException
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent
from dotenv import load_dotenv

from app.core.config import settings
from app.mcp.tools import (
    get_top_movers, get_popular_stocks, get_investor_rank, 
    get_market_data, post_trade, amend_order, 
    cancel_order, get_account_balance
)

# 1. 설정 로드
load_dotenv()
router = APIRouter()

# 2. DB 연결 함수
def get_db_connection():
    return pymysql.connect(
        host=os.getenv('DATABASE_HOST'),
        user=os.getenv('DATABASE_USERNAME'),
        password=os.getenv('DATABASE_PASSWORD'),
        db=os.getenv('DATABASE_NAME'),
        port=int(os.getenv('DATABASE_PORT', 3306)),
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

# 3. 에이전트 초기화
llm = ChatOpenAI(
    model=settings.MODEL_NAME, 
    api_key=settings.OPENAI_API_KEY,
    temperature=0
)
tools = [
    get_top_movers, get_popular_stocks, get_investor_rank, 
    get_market_data, post_trade, amend_order, 
    cancel_order, get_account_balance
]
agent_executor = create_react_agent(llm, tools)

# 4. 채팅 API 엔드포인트
@router.post("/ask")
async def chat_with_agent(query: str, room_id: int = None):
    """
    - room_id가 없으면 새 방을 만들고 시작합니다.
    - room_id가 있으면 해당 방에 대화를 이어갑니다.
    """
    conn = get_db_connection()
    try:
        # --- [STEP 1] 에이전트 실행 (답변 먼저 생성) ---
        inputs = {"messages": [HumanMessage(content=query)]}
        result = await agent_executor.ainvoke(inputs)
        final_answer = result["messages"][-1].content

        with conn.cursor() as cursor:
            # --- [STEP 2] 방이 없으면 새로 생성 ---
            if not room_id:
                # 첫 질문의 앞부분을 방 제목으로 사용
                room_title = query[:20] + "..." if len(query) > 20 else query
                # owner_user_id는 현재 테스트용으로 1로 고정
                sql_create_room = """
                INSERT INTO chat_room (owner_user_id, title, last_preview, last_sent_at) 
                VALUES (%s, %s, %s, NOW(6))
                """
                cursor.execute(sql_create_room, (1, room_title, final_answer[:100]))
                room_id = cursor.lastrowid # 새로 생성된 방 번호 가져오기
                print(f"🆕 새 채팅방 생성 완료 (ID: {room_id})")

            # --- [STEP 3] 메시지 저장 (사용자/AI) ---
            # 사용자 메시지
            cursor.execute(
                "INSERT INTO chat_message (room_id, role, content) VALUES (%s, 'user', %s)",
                (room_id, query)
            )
            # AI 메시지
            cursor.execute(
                "INSERT INTO chat_message (room_id, role, content) VALUES (%s, 'assistant', %s)",
                (room_id, final_answer)
            )

            # --- [STEP 4] 방 상태 업데이트 ---
            preview = final_answer[:250] + "..." if len(final_answer) > 250 else final_answer
            sql_update_room = """
            UPDATE chat_room 
            SET last_preview = %s, last_sent_at = NOW(6), updated_at = NOW(6)
            WHERE room_id = %s
            """
            cursor.execute(sql_update_room, (preview, room_id))

        conn.commit()
        return {
            "status": "success", 
            "room_id": room_id, # 새로 만든 방 번호를 알려줌
            "answer": final_answer
        }

    except Exception as e:
        conn.rollback()
        print(f"❌ 오류: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        conn.close()