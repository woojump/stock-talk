import json
from typing import Optional, Dict, Any

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.chat_room import ChatRoom
from app.models.chat_message import ChatMessage


# ---------------------------
# 채팅방
# ---------------------------
async def get_or_create_room(
    session: AsyncSession,
    owner_user_id: int,
) -> ChatRoom:
    result = await session.execute(
        select(ChatRoom).where(ChatRoom.owner_user_id == owner_user_id)
    )
    room = result.scalars().first()

    if room:
        return room

    room = ChatRoom(owner_user_id=owner_user_id)
    session.add(room)
    await session.commit()
    await session.refresh(room)
    return room


# ---------------------------
# 메시지 저장
# ---------------------------
async def save_user_message(
    session: AsyncSession,
    room_id: int,
    content: str,
) -> ChatMessage:
    msg = ChatMessage(
        room_id=room_id,
        role="user",
        msg_type="TEXT",
        content=content,
    )
    session.add(msg)
    await session.commit()
    await session.refresh(msg)
    return msg


async def save_assistant_text(
    session: AsyncSession,
    room_id: int,
    content: str,
    parent_id: Optional[int] = None,
) -> ChatMessage:
    msg = ChatMessage(
        room_id=room_id,
        role="assistant",
        msg_type="TEXT",
        content=content,
        parent_id=parent_id,
    )
    session.add(msg)
    await session.commit()
    return msg

def build_stock_chart_payload(stock_detail: dict) -> dict:
    """
    get_stock_detail() 결과를
    채팅용 차트 카드 payload로 변환
    """
    return {
        "card_type": "STOCK_DETAIL_CHART",
        "ticker": stock_detail["ticker"],
        "stock_info": stock_detail.get("stock_info", {}),
        "candles": stock_detail.get("candles", []),
        "meta": {
            "source": "kiwoom",
            "snapshot": True
        }
    }

async def save_chart_card(
    session: AsyncSession,
    room_id: int,
    payload: Dict[str, Any],
    parent_id: Optional[int],
) -> ChatMessage:
    msg = ChatMessage(
        room_id=room_id,
        role="assistant",
        msg_type="CARD",
        payload_json=payload,
        parent_id=parent_id,
    )
    session.add(msg)
    await session.commit()
    return msg
