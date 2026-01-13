from fastapi import APIRouter, Header, Query
from app.services.kiwoom import kiwoom_service
import asyncio

router = APIRouter()

@router.get("/top-movers")
async def get_top_movers():
    # 1. 상승 종목 TOP 5 (가격 급등)
    top_5_data = await kiwoom_service.get_top_movers(sort_tp='1')
    await asyncio.sleep(1)

    # 2. 하락 종목 TOP 5 (가격 급락)
    low_5_data = await kiwoom_service.get_top_movers(sort_tp='3')
    await asyncio.sleep(1)

    # 3. 인기 종목 TOP 5 (사람들이 많이 보는)
    popular_5_data = await kiwoom_service.get_popular_stocks(qry_tp='4') # 당일 누적 추천
    await asyncio.sleep(1)

    # 4. 많이 사는 종목 TOP 5 (기관 순매수 상위) - 추가!
    buy_5_data = await kiwoom_service.get_investor_rank(trde_tp='1', orgn_tp='9999')
    await asyncio.sleep(1)

    # 5. 많이 파는 종목 TOP 5 (기관 순매도 상위) - 추가!
    sell_5_data = await kiwoom_service.get_investor_rank(trde_tp='2', orgn_tp='9999')

    return {
        "up": top_5_data,      
        "down": low_5_data,    
        "popular": popular_5_data,
        "buy": buy_5_data,   # 큰손들이 담는 중
        "sell": sell_5_data  # 큰손들이 던지는 중
    }
    
@router.get("/condition-search")
async def search_condition(cond_id: str, authorization: str = Header(...)):
    # 지민님 작업 구간: 조건 검색 로직
    return {"message": f"{cond_id}번 조건 검색 결과"}

# 1.3 종목 상세 및 차트 - 주혁
@router.get("/stock/{ticker}/chart")
async def get_stock_chart(ticker: str, authorization: str = Header(...)):
    data = await kiwoom_service.get_market_data(f"/v1/market/chart/{ticker}", authorization)
    return data