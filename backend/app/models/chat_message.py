from sqlalchemy import (
    Column,
    BigInteger,
    Enum,
    Text,
    DateTime,
    ForeignKey,
)
from sqlalchemy.dialects.mysql import JSON
from sqlalchemy.sql import func

from app.core.database import Base


class ChatMessage(Base):
    __tablename__ = "chat_message"

    message_id = Column(BigInteger, primary_key=True, autoincrement=True)
    room_id = Column(BigInteger, ForeignKey("chat_room.room_id"), nullable=False)

    role = Column(Enum("user", "assistant"), nullable=False)
    msg_type = Column(Enum("TEXT", "CARD"), nullable=False, server_default="TEXT")

    content = Column(Text, nullable=True)
    payload_json = Column(JSON, nullable=True)

    sent_at = Column(DateTime(timezone=True), server_default=func.now())

    parent_id = Column(BigInteger, nullable=True)
    status = Column(Enum("final", "error"), default="final")
