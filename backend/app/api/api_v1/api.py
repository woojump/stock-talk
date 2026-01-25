from fastapi import APIRouter
from app.api.api_v1.endpoints import stock, trade, chat, chatting # 새 파일들 임포트

api_router = APIRouter()

api_router.include_router(stock.router, prefix="/market", tags=["market"])
api_router.include_router(trade.router, prefix="/trade", tags=["trade"])
api_router.include_router(chat.router, prefix="/chat", tags=["chat"])
api_router.include_router(chatting.router, prefix="/chatting", tags=["chatting"])

