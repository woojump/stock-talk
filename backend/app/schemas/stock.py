from pydantic import BaseModel, Field
from typing import List, Optional

# 1.1 & 1.2 공통으로 사용할 종목 기본 정보
class StockBase(BaseModel):
    ticker: str = Field(..., description="종목 코드 (예: 005930)")
    name: str = Field(..., description="종목명")
    current_price: int = Field(..., description="현재가")
    change_rate: float = Field(..., description="전일 대비 등락률")

# 1.1 상위 종목 응답 규격
class TopMoversResponse(BaseModel):
    status: str = "success"
    data: List[StockBase]

# 1.2 종목 검색 응답 규격 (돋보기 기능)
class StockSearchResponse(BaseModel):
    search_query: str
    count: int
    data: List[StockBase]

# 1.4 수동 주문 요청 규격 (Input)
class OrderRequest(BaseModel):
    ticker: str
    qty: int
    price: Optional[int] = 0  # 0이면 시장가
    type: str = "market"      # market, limit
    side: str = "buy"         # buy, sell