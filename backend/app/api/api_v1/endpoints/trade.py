from fastapi import APIRouter, Header
from app.services.kiwoom import kiwoom_service
from pydantic import BaseModel

router = APIRouter()

class OrderRequest(BaseModel):
    ticker: str
    qty: int
    price: int
    type: str # market, limit 등

# 1.4 수동 주문 - 팀 전체 공통
@router.post("/order")
async def place_order(order_data: dict, authorization: str = Header(...)):
    # 팀원 B 작업 구간: 실제 주문 실행 로직
    return {"status": "success"}