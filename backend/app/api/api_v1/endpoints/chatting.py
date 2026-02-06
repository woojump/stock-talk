import os
import re
import pymysql
import json
from typing import Any, Dict, Optional, List
import asyncio

from fastapi import APIRouter, HTTPException, Query
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent
from dotenv import load_dotenv
from langgraph.checkpoint.memory import MemorySaver
from datetime import datetime

from app.core.config import settings
from app.services.kiwoom import kiwoom_service
from app.mcp.tools import (
    get_top_movers, get_popular_stocks, get_investor_rank, 
    get_market_data, post_trade, amend_order, 
    cancel_order, get_account_balance, get_order_history,
    get_stock_news_items, answer_with_news
)

from app.callbacks.tool_call_log_handler import ToolCallLogHandler

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
    cancel_order, get_account_balance, get_order_history,
    get_stock_news_items, answer_with_news
]

# 시스템 프롬프트
SYSTEM_PROMPT_DICT = {
    "role": "당신은 주식 초보자를 위한 대화형 비서입니다. 목표는 사용자의 자산 보호와 쉬운 설명입니다.",

    "core_rules": [
        "주식/경제 관련 질문만 응답한다. 범위를 벗어나면 정중히 안내하고 주식 질문으로 유도한다.",
        "확인되지 않은 사실을 단정하지 않는다. 도구 결과가 없으면 '확인 불가'를 명시한다.",
        "내부 절차/정책 키/단계 문구(예: '1단계', '[상태 확인]')를 사용자에게 절대 출력하지 않는다."
    ],

    "tool_policy": {
        "news": [
            "사용자 질문에 뉴스/기사/이슈/왜 오름/왜 떨어짐/원인/근거가 포함되면 뉴스 질문으로 간주한다.",
            "뉴스 질문이면 우선 answer_with_news(stock_name, question)을 호출한다.",
            "뉴스는 기사 본문에서 추출된 facts 기반으로만 답한다. 추측 금지.",
            "뉴스 답변은 TEXT로만 작성한다(링크/URL 제공은 생략)."
        ],
        "market_data": [
            "사용자가 시세/현재가/주가를 물으면 get_market_data를 호출한다.",
            "종목이 모호하면 get_market_data의 안내에 따라 사용자에게 재질문한다.",
            "여러 종목이면 누락 없이 각각 get_market_data를 호출한다."
        ],
        "trading": [
            "매수/매도 주문(post_trade)은 사용자의 명확한 승인 이후에만 실행한다.",
            "정정/취소는 get_order_history로 주문번호를 먼저 확인한 뒤 수행한다."
        ]
    },

    "risk_management": [
        "변동성이 큰 테마주/잡주 언급 시 위험성을 짧게 경고한다.",
        "예수금의 큰 비중을 한 종목에 쓰려 하면 분산을 권유한다.",
        "장외시간에는 주문이 예약 접수될 수 있음을 안내한다."
    ],

    "tone": [
        "초보자에게 친절하고 간단하게 설명한다.",
        "긴 설명이 필요하면 요점부터 짧게, 원하면 자세히 설명한다고 덧붙인다."
    ]
}

SYSTEM_PROMPT = json.dumps(SYSTEM_PROMPT_DICT, ensure_ascii=False, indent=2)

memory = MemorySaver()

agent_executor = create_react_agent(
    llm, 
    tools, 
    checkpointer=memory,
    prompt=SYSTEM_PROMPT 
)


def _safe_json_load(s: str) -> Optional[Dict[str, Any]]:
    try:
        obj = json.loads(s)
        return obj if isinstance(obj, dict) else None
    except Exception:
        return None


def _build_chart_card_payload(stock_detail: Dict[str, Any]) -> Dict[str, Any]:
    ticker = stock_detail.get("ticker")
    stock_info = stock_detail.get("stock_info", {})
    candles = stock_detail.get("candles", [])

    # candles가 최신->과거면 차트용으로 과거->최신 정렬(선택)
    # time이 YYYYMMDD라 가정
    try:
        candles_sorted = sorted(candles, key=lambda x: x.get("time") or "")
    except Exception:
        candles_sorted = candles

    return {
        "card_type": "price_chart",
        "title": f"{ticker} 차트",
        "ticker": ticker,
        "range": "1M",
        "interval": "1D",
        "summary": stock_info,
        "candles": candles_sorted,
    }


CHART_INTENT_RE = re.compile(r"(시세|현재가|주가|차트|그래프|캔들|추세|흐름)", re.IGNORECASE)

def detect_need_chart(query: str) -> bool:
    return bool(CHART_INTENT_RE.search(query or ""))


# 4. 채팅 API 엔드포인트
@router.post("/ask")
async def chat_with_agent(query: str, room_id: int = None):
    need_chart = detect_need_chart(query)
    conn = get_db_connection()
    user_msg_id = None
    try:
        with conn.cursor() as cursor:
            if room_id is not None:
                cursor.execute("SELECT 1 FROM chat_room WHERE room_id=%s", (room_id,))
                exists = cursor.fetchone()
            else:
                exists = None
            # --- [STEP 1] room_id가 없거나 DB에 없으면 채팅방 생성 ---
            if room_id is None or not exists:
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

            # 현재 시간을 구해서 질문 앞에 붙여줌.
            current_now = datetime.now().strftime("%Y-%m-%d %H:&M:%S")
            rich_query = f"[현재 시간: {current_now}]\n{query}"

            inputs = {"messages": [HumanMessage(content=rich_query)]}
            
            # --- [STEP 2] 메시지 저장 (사용자) ---
            cursor.execute(
                """
                INSERT INTO chat_message (room_id, role, msg_type, content, status)
                VALUES (%s, 'user', 'TEXT', %s, 'final')
                """,
                (room_id, query),
            )
            user_msg_id = cursor.lastrowid
            conn.commit()

            # ✅ ToolCallLog handler 만들고 callbacks로 주입
            handler = ToolCallLogHandler(
                conn=conn,
                room_id=room_id,
                message_id=user_msg_id,
                parent_id=user_msg_id,  # 보통 tool call은 “이 유저 질문에 대한 실행”이니까 parent를 user_msg로 두는게 자연스러움
            )

            # --- [STEP 3] 에이전트 실행 (이 부분이 에러 해결의 핵심) ---
            # 💡 반드시 thread_id를 문자열로 변환하여 전달해야 합니다.
            config = {
                "configurable": {"thread_id": str(room_id)},
                "callbacks": [handler],
            }
            
            inputs = {"messages": [HumanMessage(content=query)]}

            print(f"🤖 에이전트 호출 시작 (thread_id: {room_id})")
            # 🚀 두 번째 인자로 config를 반드시 넘깁니다.
            result = await agent_executor.ainvoke(inputs, config=config)
            final_answer = result["messages"][-1].content

            answer_text = final_answer
            need_chart = detect_need_chart(query)

            if need_chart and not handler.tickers:
                answer_text = (
                    answer_text.strip()
                    + "\n\n차트를 보여드리려면 정확한 종목명이 필요해요. 예: '삼성전자 차트 보여줘'처럼 입력해 주세요."
                )

            messages: List[Dict[str, Any]] = []

            # --- [STEP 4] 메시지 저장 (AI) ---
            cursor.execute(
                """
                INSERT INTO chat_message (room_id, role, msg_type, content, parent_id, status)
                VALUES (%s, 'assistant', 'TEXT', %s, %s, 'final')
                """,
                (room_id, answer_text, user_msg_id),
            )
            assistant_text_id = cursor.lastrowid
            last_message_id = assistant_text_id
            messages.append({"role": "assistant", "msg_type": "TEXT", "content": answer_text})

            # 차트가 필요하면 서버가 직접 get_stock_detail 호출 후 CARD 저장

            if need_chart and handler.tickers:
                # "000660,005930" -> ["000660", "005930"]
                ticker_list = handler.tickers[:]
                
                print(f"📡 총 {len(ticker_list)}개의 종목 차트를 생성합니다: {ticker_list}")

                for i, t in enumerate(ticker_list):
                    try:
                        # 🚀 [추가] 두 번째 종목부터는 0.5초 대기하여 429 에러 방지
                        if i > 0:
                            await asyncio.sleep(1.0)

                        # 각 종목 상세 데이터 호출
                        stock_detail = await kiwoom_service.get_stock_detail(t)
                        card_payload = _build_chart_card_payload(stock_detail)

                        # 각 종목별로 개별 카드 저장
                        cursor.execute(
                            """
                            INSERT INTO chat_message (room_id, role, msg_type, payload_json, parent_id, status)
                            VALUES (%s, 'assistant', 'CARD', %s, %s, 'final')
                            """,
                            (room_id, json.dumps(card_payload, ensure_ascii=False), assistant_text_id),
                        )
                        
                        # 마지막 카드 ID 업데이트 (STEP 4에서 사용)
                        last_message_id = cursor.lastrowid
                        
                        # 화면 반환 리스트에 추가
                        messages.append({"role": "assistant", "msg_type": "CARD", "payload_json": card_payload})
                        print(f"✅ {t} 차트 생성 완료")
                    except Exception as e:
                        print(f"⚠️ {t} 차트 생성 중 오류: {str(e)}")

            # --- [STEP 4] 방 정보 최종 업데이트 ---

            room_title = query[:20] + "..." if len(query) > 20 else query
            preview_src = (answer_text or "").strip() or (final_answer or "").strip()
            preview = preview_src[:250] + "..." if len(preview_src) > 250 else preview_src

            sql_update_room = """
            UPDATE chat_room 
            SET title = %s, last_message_id = %s, last_preview = %s, last_sent_at = NOW(6), updated_at = NOW(6)
            WHERE room_id = %s
            """
            cursor.execute(sql_update_room, (room_title, last_message_id, preview, room_id))
            conn.commit()

        return {
            "status": "success", 
            "room_id": room_id, 
            "messages": messages
        }

    except Exception as e:
        print(f"❌ 에러 상세 발생: {str(e)}")

        # 1) DB 연결/room_id가 없으면 DB 저장 자체를 포기
        if conn is None:
            return {"status": "error", "room_id": None, "message": "DB 연결 실패"}

        if room_id is None:
            return {"status": "error", "room_id": None, "message": "시스템 오류가 발생했습니다."}

        error_text = "시스템 오류로 답변을 생성하지 못했습니다. 잠시 후 다시 시도해 주세요."

        # user_msg_id는 try 내부에서 생성되었을 수도/안되었을 수도 있음
        user_msg_id = locals().get("user_msg_id")  # 없으면 None

        try:
            with conn.cursor() as cursor:
                # 2) 에러 메시지 저장 (assistant, TEXT) + parent_id 연결
                cursor.execute(
                    """
                    INSERT INTO chat_message (room_id, role, msg_type, content, parent_id, status)
                    VALUES (%s, 'assistant', 'TEXT', %s, %s, 'error')
                    """,
                    (room_id, error_text, user_msg_id),
                )
                error_msg_id = cursor.lastrowid

                # 3) chat_room last_* 업데이트 (에러도 최신 메시지로 반영)
                room_title = query[:20] + "..." if len(query) > 20 else query
                preview_src = error_text.strip()
                preview = preview_src[:250] + "..." if len(preview_src) > 250 else preview_src

                cursor.execute(
                    """
                    UPDATE chat_room
                    SET title=%s,
                        last_message_id=%s,
                        last_preview=%s,
                        last_sent_at=NOW(6),
                        updated_at=NOW(6)
                    WHERE room_id=%s
                    """,
                    (room_title, error_msg_id, preview, room_id),
                )
                conn.commit()

        except Exception:
            pass  # 에러 중 에러는 무시 (로그만 남기면 됨)

        return {
            "status": "error",
            "room_id": room_id,
            "message": "시스템 오류가 발생했습니다."
        }

    finally:
        if conn:
            conn.close()



# -----------------------------
# 1) 채팅방 목록 조회
# GET /rooms?limit=50&offset=0
# -----------------------------
@router.get("/rooms")
async def list_rooms(limit: int = Query(50, ge=1, le=200), offset: int = Query(0, ge=0)):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute(
                """
                SELECT room_id, owner_user_id, title, last_preview, last_message_id, last_sent_at, updated_at
                FROM chat_room
                ORDER BY last_sent_at DESC
                LIMIT %s OFFSET %s
                """,
                (limit, offset),
            )
            rooms = cursor.fetchall()
        return {"status": "success", "data": rooms}
    finally:
        conn.close()


# --------------------------------------------
# 2) 채팅방 내역 조회 (room_id로 메시지 불러오기)
# GET /rooms/{room_id}/messages?limit=200&before_id=...
# --------------------------------------------
@router.get("/rooms/{room_id}/messages")
async def get_room_messages(
    room_id: int,
    limit: int = Query(200, ge=1, le=500),
    before_id: Optional[int] = Query(None, description="페이징용: 이 메시지 ID보다 작은 것들만 조회"),
):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            # 방 존재 확인
            cursor.execute("SELECT 1 FROM chat_room WHERE room_id=%s", (room_id,))
            if not cursor.fetchone():
                raise HTTPException(status_code=404, detail="chat room not found")

            if before_id is None:
                cursor.execute(
                    """
                    SELECT message_id, room_id, role, msg_type, content, payload_json, parent_id, status, sent_at
                    FROM chat_message
                    WHERE room_id=%s
                    ORDER BY message_id DESC
                    LIMIT %s
                    """,
                    (room_id, limit),
                )
            else:
                cursor.execute(
                    """
                    SELECT message_id, room_id, role, msg_type, content, payload_json, parent_id, status, sent_at
                    FROM chat_message
                    WHERE room_id=%s AND message_id < %s
                    ORDER BY message_id DESC
                    LIMIT %s
                    """,
                    (room_id, before_id, limit),
                )

            msgs = cursor.fetchall()

            # payload_json이 문자열로 들어있으면 dict로 변환해서 내려주고 싶을 때(옵션)
            for m in msgs:
                if m.get("payload_json"):
                    try:
                        m["payload_json"] = json.loads(m["payload_json"])
                    except Exception:
                        pass

        return {"status": "success", "room_id": room_id, "messages": list(reversed(msgs))}
    finally:
        conn.close()


# -----------------------------
# 3) 채팅방 삭제
# DELETE /rooms/{room_id}
# -----------------------------
@router.delete("/rooms/{room_id}")
async def delete_room(room_id: int):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute("SELECT 1 FROM chat_room WHERE room_id=%s", (room_id,))
            if not cursor.fetchone():
                raise HTTPException(status_code=404, detail="chat room not found")

            # 메시지 먼저 삭제 (FK cascade 없을 경우 필수)
            cursor.execute("DELETE FROM chat_message WHERE room_id=%s", (room_id,))
            cursor.execute("DELETE FROM chat_room WHERE room_id=%s", (room_id,))
            conn.commit()

        return {"status": "success", "room_id": room_id}
    finally:
        conn.close()
