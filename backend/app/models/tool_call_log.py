from sqlalchemy import (
    Column,
    BigInteger,
    String,
    Enum,
    Text,
    DateTime,
    ForeignKey,
)
from sqlalchemy.dialects.mysql import JSON
from sqlalchemy.sql import func

from app.core.database import Base


class ToolCallLog(Base):
    __tablename__ = "tool_call_log"

    tool_call_id = Column(BigInteger, primary_key=True, autoincrement=True)

    room_id = Column(BigInteger, ForeignKey("chat_room.room_id"), nullable=False)
    message_id = Column(BigInteger, nullable=True)
    parent_id = Column(BigInteger, nullable=True)

    tool_name = Column(String(100), nullable=False)
    tool_type = Column(Enum("read", "write", "trade"), default="read")

    request_json = Column(JSON, nullable=False)
    response_json = Column(JSON, nullable=True)

    status = Column(Enum("success", "error"), nullable=False)
    error_code = Column(String(50), nullable=True)
    error_message = Column(Text, nullable=True)

    started_at = Column(DateTime(timezone=True), server_default=func.now())
    finished_at = Column(DateTime(timezone=True), nullable=True)
    latency_ms = Column(BigInteger, nullable=True)
