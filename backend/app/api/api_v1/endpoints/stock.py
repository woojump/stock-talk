from fastapi import APIRouter, Header, Query
from app.services.kiwoom import kiwoom_service

router = APIRouter()

@router.get("/top-movers")
async def get_top_movers(authorization: str = Header(...)):
    #sort_tp = '1'은 상승률 '3'은 하락률   
    top_5_data = await kiwoom_service.get_top_movers(sort_tp='1')
    return top_5_data
    
@router.get("/condition-search")
async def search_condition(cond_id: str, authorization: str = Header(...)):
    # 지민님 작업 구간: 조건 검색 로직
    return {"message": f"{cond_id}번 조건 검색 결과"}

# 1.3 종목 상세 및 차트 - 주혁
@router.get("/stock/{ticker}/chart")
async def get_stock_chart(ticker: str, authorization: str = Header(...)):
    data = await kiwoom_service.get_market_data(f"/v1/market/chart/{ticker}", authorization)
    return data