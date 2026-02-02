from sqlalchemy import Column, BigInteger, String, DateTime
from sqlalchemy.sql import func

from app.core.database import Base


class StockInfo(Base):
    __tablename__ = "stock_info"

    # ticker: Code (005930 등)
    ticker = Column(String(20), primary_key=True)

    # name: 종목명
    name = Column(String(100), nullable=False)

    # market: KOSPI/KOSDAQ/KONEX 등
    market = Column(String(20), nullable=True)

    # dept: 우량기업부 등(있으면)
    dept = Column(String(50), nullable=True)

    # marcap: 시가총액
    marcap = Column(BigInteger, nullable=True)

    # market_id: STK/KSQ 등
    market_id = Column(String(20), nullable=True)

    # chosung: 초성 검색용 ("삼성전자" -> "ㅅㅅㅈㅈ")
    chosung = Column(String(200), nullable=True)

    # updated_at: 갱신 시각 (서버 시간 기준)
    updated_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False,
    )
