import asyncio

from app.core.database import engine, Base
from app.models.chat_room import ChatRoom
from app.models.chat_message import ChatMessage
from app.models.tool_call_log import ToolCallLog


async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    # ✅ Windows + aiomysql에서 종료 경고 방지
    await engine.dispose()


if __name__ == "__main__":
    asyncio.run(init_db())
