from fastapi import APIRouter, Header
from app.services.kiwoom import kiwoom_service
from pydantic import BaseModel

router = APIRouter()

class OrderRequest(BaseModel):
    ticker: str
    qty: int
    price: int
    type: str # market, limit 등


@router.get("/balance")
async def get_my_balance():
    """마이페이지용 실시간 계좌 및 보유 종목 조회 API"""
    # 내부적으로 KiwoomService가 토큰과 계좌번호를 관리하므로 별도 입력 불필요
    result = await kiwoom_service.get_account_balance()
    return result