from pydantic import BaseModel
from typing import Optional

class TradeRequest(BaseModel):
    app_key: str        # 앱에서 보낸 키움 App Key
    app_secret: str     # 앱에서 보낸 키움 App Secret
    ticker: str         # 종목 코드
    quantity: int       # 수량
    price: Optional[int] = 0 # 시장가일 경우 0