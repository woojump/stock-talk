from fastapi import APIRouter
from app.api.api_v1.endpoints import stock, trade # 새 파일들 임포트

api_router = APIRouter()

api_router.include_router(stock.router, prefix="/market", tags=["market"])
api_router.include_router(trade.router, prefix="/trade", tags=["trade"])