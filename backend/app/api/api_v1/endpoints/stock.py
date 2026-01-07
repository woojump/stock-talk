from fastapi import APIRouter, Header, Query
from app.services.kiwoom import kiwoom_service

router = APIRouter()

@router.get("/top-movers")
async def get_top_movers(authorization: str = Header(...)):
    # 동균님 작업 구간: 
    # 1. kiwoom_service를 이용해 키움 서버에 데이터 요청
    # 2. 결과 데이터를 Flutter가 보기 좋게 가공
    return {"message": "상승률 상위 종목 결과"}

@router.get("/condition-search")
async def search_condition(cond_id: str, authorization: str = Header(...)):
    # 지민님 작업 구간: 조건 검색 로직
    return {"message": f"{cond_id}번 조건 검색 결과"}

# 1.3 종목 상세 및 차트 - 주혁
@router.get("/stock/{ticker}/chart")
async def get_stock_chart(ticker: str, authorization: str = Header(...)):
    data = await kiwoom_service.get_market_data(f"/v1/market/chart/{ticker}", authorization)
    return data