from fastapi import APIRouter
from pydantic import BaseModel

from app.core.database import AsyncSessionLocal
from app.services.chat_service import (
    get_or_create_room,
    save_user_message,
    save_chart_card,
)

router = APIRouter()


class ChatAskRequest(BaseModel):
    user_id: int
    message: str
    ticker: str


@router.post("/ask")
async def chat_ask(req: ChatAskRequest):
    async with AsyncSessionLocal() as session:
        # 1) 채팅방
        room = await get_or_create_room(session, req.user_id)

        # 2) 사용자 메시지 저장
        user_msg = await save_user_message(
            session,
            room.room_id,
            req.message,
        )

        # 3) (지금은 LLM 대신) 차트 카드 더미 생성
        chart_payload = {
            "card_type": "STOCK_DETAIL_CHART",
            "ticker": req.ticker,
            "candles": [],  # ← 나중에 /stock/{ticker}/detail 결과 넣기
        }

        assistant_msg = await save_chart_card(
            session,
            room.room_id,
            payload=chart_payload,
            parent_id=user_msg.message_id,
        )

        return {
            "roomId": room.room_id,
            "messages": [
                {
                    "messageId": user_msg.message_id,
                    "type": "text",
                    "content": user_msg.content,
                },
                {
                    "messageId": assistant_msg.message_id,
                    "type": "card",
                    "payload": chart_payload,
                },
            ],
        }
