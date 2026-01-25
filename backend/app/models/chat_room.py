from sqlalchemy import Column, BigInteger, String, DateTime
from sqlalchemy.sql import func

from app.core.database import Base


class ChatRoom(Base):
    __tablename__ = "chat_room"

    room_id = Column(BigInteger, primary_key=True, autoincrement=True)
    owner_user_id = Column(BigInteger, nullable=False)

    title = Column(String(200), nullable=True)

    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
    )

    last_message_id = Column(BigInteger, nullable=True)
    last_preview = Column(String(300), nullable=True)
    last_sent_at = Column(DateTime(timezone=True), nullable=True)
