import os
import pymysql
from fastapi import APIRouter, HTTPException
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent
from dotenv import load_dotenv
from langgraph.checkpoint.memory import MemorySaver

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

# 시스템 프롬프트
SYSTEM_PROMPT = """
당신은 'Stock-Talk'의 전문 주식 매매 비서입니다. 
사용자의 매수/매도 요청을 처리할 때 다음 단계를 반드시 엄수하세요.

2. [상세 확인]: 주문 실행 전 '수량'과 '주문 방식(시장가 혹은 지정가)'을 반드시 사용자에게 물어보세요.
3. [티키타카]: 정보가 하나라도 누락되었다면 절대 'post_trade'를 호출하지 말고 대화로 물어보세요.
   - 예: "삼성전자 10주 매수 주문을 도와드릴까요? 시장가로 진행할지, 아니면 원하는 가격이 있으신지 말씀해 주세요."
4. [최종 컨펌]: 모든 조건이 갖춰지면 사용자에게 내용을 요약해 보여주고 최종 승인을 받은 뒤에 주문을 실행하세요.
"""

memory = MemorySaver()

agent_executor = create_react_agent(
    llm, 
    tools, 
    checkpointer=memory,
    prompt=SYSTEM_PROMPT 
)

# 4. 채팅 API 엔드포인트
@router.post("/ask")
async def chat_with_agent(query: str, room_id: int = None):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            # --- [STEP 1] room_id가 없으면 DB에 먼저 생성하여 thread_id 확보 ---
            if room_id is None:
                sql_create_room = """
                INSERT INTO chat_room (owner_user_id, title, last_preview, last_sent_at) 
                VALUES (%s, %s, %s, NOW(6))
                """
                # 에이전트 실행 전이므로 임시 제목으로 생성
                cursor.execute(sql_create_room, (1, query[:20], "답변 생성 중..."))
                room_id = cursor.lastrowid
                conn.commit()  # DB에 즉시 반영하여 ID 확정
                print(f"🆕 새 채팅방 생성 완료 (ID: {room_id})")

            # --- [STEP 2] 에이전트 실행 (이 부분이 에러 해결의 핵심) ---
            # 💡 반드시 thread_id를 문자열로 변환하여 전달해야 합니다.
            config = {"configurable": {"thread_id": str(room_id)}}
            inputs = {"messages": [HumanMessage(content=query)]}
            
            print(f"🤖 에이전트 호출 시작 (thread_id: {room_id})")
            # 🚀 두 번째 인자로 config를 반드시 넘깁니다.
            result = await agent_executor.ainvoke(inputs, config=config)
            final_answer = result["messages"][-1].content

            # --- [STEP 3] 메시지 저장 (사용자/AI) ---
            cursor.execute(
                "INSERT INTO chat_message (room_id, role, content) VALUES (%s, 'user', %s)",
                (room_id, query)
            )
            cursor.execute(
                "INSERT INTO chat_message (room_id, role, content) VALUES (%s, 'assistant', %s)",
                (room_id, final_answer)
            )

            # --- [STEP 4] 방 정보 최종 업데이트 (진짜 답변 내용 반영) ---
            room_title = query[:20] + "..." if len(query) > 20 else query
            preview = final_answer[:250] + "..." if len(final_answer) > 250 else final_answer
            sql_update_room = """
            UPDATE chat_room 
            SET title = %s, last_preview = %s, last_sent_at = NOW(6), updated_at = NOW(6)
            WHERE room_id = %s
            """
            cursor.execute(sql_update_room, (room_title, preview, room_id))
            conn.commit()

        return {
            "status": "success", 
            "room_id": room_id, 
            "answer": final_answer
        }

    except Exception as e:
        print(f"❌ 에러 상세 발생: {str(e)}")
        return {"status": "error", "message": str(e)}
    finally:
        if conn:
            conn.close()