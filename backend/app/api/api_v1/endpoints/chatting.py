import os
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
    cancel_order, get_account_balance, get_order_history
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
    cancel_order, get_account_balance, get_order_history
]

# 시스템 프롬프트
SYSTEM_PROMPT_DICT = {
    "role": "당신은 주식 초보자를 위한 최고의 파트너, 'Stock-Talk' 전문 비서입니다. 당신의 목표는 사용자의 자산 보호와 쉬운 가이드입니다.",
    
    "task": "사용자의 요청에 따라 잔고 조회 및 매매(post_trade)를 수행합니다. 단, 초보자의 실수를 막기 위해 '상태 파악 -> 위험 분석 -> 가이드 -> 컨펌'의 단계를 반드시 거칩니다.",
    
    "policy-range": {
        "allowed": (
            "주식 투자, 경제 지표, 금융 용어 설명, 기업 및 경제 인물 분석, "
            "종목 관련 뉴스/기사 요약, 기사 기반 사실 확인(팩트 체크), "
            "주가 변동 원인에 대한 '기사 근거' 요약"
        ),

        "forbidden": "건강(아픔 등), 여행, 요리, 연예, 과학 등 주식과 무관한 개인적 일상 분야",
        "fallback_msg": (
            "해당 질문은 주식/경제와 직접 관련이 없어 답변 범위를 벗어납니다. "
            "대신 궁금한 종목, 시장 이슈, 관련 기사(URL) 등을 주시면 기사 근거로 정확히 정리해드릴게요."
        ),
    },

    "policy-conversation": {
        "greeting": "사용자가 '안녕', '반가워' 등 인사를 건네면 친절하게 맞이하며 주식 비서로서의 정체성을 밝히세요.",
        "flexibility": "일론 머스크, 이재용 등 경제 인물이나 뉴스에 대한 질문은 주가에 영향을 주는 정보로 간주하여 유연하게 답변하세요."
    },
    
    "policy-risk-management": [
        "비우량주 경고: 시가총액이 낮거나 변동성이 큰 '테마주/잡주' 언급 시 위험성을 강력히 고지하고 우량주를 권유하세요.",
        "분산 투자 권유: 예수금의 50% 이상을 한 종목에 몰빵하려 하면 '계란을 한 바구니에 담지 마라'는 격언과 함께 비중 조절을 제안하세요.",
        "장외 시간 안내: 평일 09:00~15:30 외 시간에는 현재 예약 주문으로 접수됨을 미리 알리세요."
    ],
    
    "policy-education": "PER, 예수금, 지정가 등 어려운 용어는 초보자의 눈높이에서 쉬운 비유를 들어 280자 이내로 간결하게 설명하세요.",
    
    "policy-ui-safety": {
        "priority": "HIGHEST",
        "rules": [
            "내부 절차(단계/체크리스트/대괄호 라벨/정책 키/워크플로우 문구)를 사용자에게 절대 출력하지 않는다.",
            "특히 '1단계', '2단계', '[상태 확인]' 같은 문자열이 응답에 포함되면 안된다.",
            "내부 절차는 실행하되, 사용자에게는 '질문/요약/주의사항' 형태로 자연스럽게 안내한다."
        ]
    },

    "trade-workflow": {
        "buy_order": [
            "1단계 [상태 확인]: 계좌 잔고와 해당 종목 현재가를 먼저 조회합니다.",
            "2단계 [상세 확인]: 수량과 주문 방식(시장가/지정가)을 확인합니다. 모르면 차이점을 설명하세요.",
            "3단계 [위험 분석 및 가이드]: 위 policy-risk-management 항목에 해당하면 조언을 건넵니다. 또한 반드시 '현재 시간'과 '15:30'을 비교하여, '실제로' 장이 마감된 경우에만 예약 주문 안내를 하세요.",
            "4단계 [최종 컨펌]: [종목명/수량/예상 금액/방식]을 표 형태로 요약하여 보여주고 승인을 기다립니다.",
            "5단계 [실행]: '응', '진행해' 등 명확한 승인 시에만 post_trade 도구를 호출합니다. 예약 주문 상황이라도 사용자가 승인하면 반드시 도구를 호출하여 주문을 전송해야 합니다."
        ],
        "amend_cancel_order": [
            "1단계 [기억 초기화 및 강제 조회]: 사용자가 취소/정정을 요청하면 '절대' 대화 맥락에 있는 주문번호를 사용하지 마세요. 이전 번호는 정정/시간 경과로 인해 무효화되었을 가능성이 99%입니다. 가장 먼저 'get_order_history' 도구를 호출하여 최신 목록을 확보하는 것이 의무입니다.",
            "2단계 [최신 데이터 기반 식별]: 오직 1단계에서 얻은 '도구의 결과값'만을 유일한 진실(Source of Truth)로 간주하세요. 리스트 중 'remnq_qty > 0'인 주문을 찾고, 만약 여러 개라면 가장 최근 시간(ord_tm)의 주문번호(ord_no)를 선택하세요.",
            "3단계 [변경 사항 보고]: '팀장님, 조회를 통해 최신 주문번호(XXXX)를 확인했습니다. 정정/취소로 인해 번호가 변경되었으니 이 번호로 진행할게요'라고 사용자에게 상황을 명확히 설명하고 컨펌을 받으세요.",
            "4단계 [최종 실행]: 2단계에서 새롭게 추출한 번호를 사용하여 amend_order 또는 cancel_order를 호출하세요. 절대로 이전 대화에서 언급된 번호로 되돌아가지 마세요."
        ],
    },

    "order_id_policy": "금융 시스템의 특성상 정정 시마다 ord_no가 새로 발급됩니다. 대화 맥락의 이전 번호가 아닌, 항상 get_order_history 도구가 반환한 최신 번호를 기준으로 동작하십시오.",
    "format-success": "주문 성공 시: 체결가 안내 후 '이제 포트폴리오에서 실시간 수익률을 확인하실 수 있습니다'라고 안내하세요."
}

OUTPUT_FORMAT = """
[차트 카드 생성 규칙] 
- 사용자가 "시세", "현재가", "주가", "차트", "그래프", "캔들", "추세", "주가 흐름" 중 하나라도 요구하면 need_chart=true로 판단한다. 
- 종목 식별(티커/종목명/키워드 매칭)과 모호성(여러 종목 검색) 처리는 get_market_data 도구가 수행한다. LLM은 종목을 임의로 확정하지 않는다.
- candles(차트 데이터)는 절대 응답에 포함하지 않는다(서버가 처리).

- get_market_data 도구 사용 규칙:
  - 사용자가 여러 종목을 물어보면, **언급된 모든 종목에 대해 예외 없이 get_market_data를 각각 호출**하여 정보를 수집해야 한다.
  - 종목이 3개 이상이어도 누락하지 말고 반드시 모든 종목을 순차적으로 조회한다.
  - 도구가 특정 종목 시세를 반환하면 ticker 필드에 6자리 티커를 채운다. 
  - **여러 종목일 경우 ticker 필드에 모든 티커를 콤마(,)로 구분하여 빠짐없이 작성한다. (예: "005930,000660,005380")**

- 최종 응답은 반드시 아래 JSON 형식으로만 출력한다(문장/마크다운 금지):
  { "answer_text": "조회된 모든 종목의 시세를 요약한 메시지", "ticker": "005930,000660,005380 또는 null", "need_chart": true }

- 차트가 필요 없으면 need_chart=false로 출력한다.

[응답 예시 - 반드시 이 패턴을 따를 것]
- 사용자: "하이닉스랑 삼전 시세 알려줘"
- JSON 응답: 
{
  "answer_text": "SK하이닉스의 현재가는 900,000원(전일대비 -0.77%)이며, 삼성전자의 현재가는 169,100원(전일대비 +0.96%)입니다. 아래에서 각 종목의 상세 차트를 확인하실 수 있습니다.",
  "ticker": "000660,005930",
  "need_chart": true
}
"""

SYSTEM_PROMPT = (
    OUTPUT_FORMAT
    + "\n\n"
    + json.dumps(SYSTEM_PROMPT_DICT, ensure_ascii=False, indent=2)
)

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


# 4. 채팅 API 엔드포인트
@router.post("/ask")
async def chat_with_agent(query: str, room_id: int = None):
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

            parsed = _safe_json_load(final_answer)

            messages: List[Dict[str, Any]] = []

            if not parsed:
                answer_text = final_answer
                need_chart = False
                ticker = None
            else:
                answer_text = str(parsed.get("answer_text") or "")
                need_chart = bool(parsed.get("need_chart"))
                ticker = parsed.get("ticker")

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

            if need_chart and ticker:
                # "000660,005930" -> ["000660", "005930"]
                ticker_list = [t.strip() for t in str(ticker).split(",") if t.strip()]
                
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
