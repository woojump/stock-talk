from __future__ import annotations

import asyncio
from typing import Dict, List, Set, Tuple

import pandas as pd
from fastapi import APIRouter, Query

from app.services.kiwoom import kiwoom_service
from app.services.finance_data_reader import finance_data_service

router = APIRouter()
  
# 1.1 상위 종목
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
    
    
# 1.2 종목 검색
@router.get("/re_search")
async def search(query: str = Query(...)):
    return finance_data_service.search(query)

# 1.3 종목 상세 및 차트
@router.get("/stock/{ticker}/detail")
async def get_stock_detail(ticker: str):
    """
    1.3 종목 상세 및 차트 데이터 통합 엔드포인트
    - ka10004: 실시간 호가 및 현재가 정보
    - ka10005: 캔들 차트용 일별 주가 데이터
    """
    # 1. 실시간 호가 정보 가져오기 (ka10004)
    quote_data = await kiwoom_service.get_market_data(api_id="ka10004", stk_cd=ticker)
    
    # 2. 차트 데이터 가져오기 (ka10005)
    chart_raw = await kiwoom_service.get_market_data(api_id="ka10005", stk_cd=ticker)
    
    # 2. 터미널에 원본 데이터 출력 (여기가 핵심!)
    print("\n" + "="*50)
    print(f"🔍 [DEBUG] 종목코드: {ticker}")
    print(f"📈 [호가 원본(ka10004)]: {quote_data}")
    print(f"📊 [차트 원본(ka10005)]: {chart_raw}")
    print("="*50 + "\n")

    # 3. 기존 가공 로직
    # (여기서 에러가 나더라도 위에서 print는 찍힙니다.)
    try:
        # 데이터가 담긴 리스트 추출 (안전하게 get 사용)
        raw_candles = chart_raw.get("stk_ddwkmm", [])
        
        processed_candles = [
            {
                "time": item.get("date"),
                # 부호(+, -)를 제거하고 정수(int)로 변환
                "open": int(item.get("open_pric", "0").replace("+", "").replace("-", "")),
                "high": int(item.get("high_pric", "0").replace("+", "").replace("-", "")),
                "low": int(item.get("low_pric", "0").replace("+", "").replace("-", "")),
                "close": int(item.get("close_pric", "0").replace("+", "").replace("-", "")),
                "volume": int(item.get("trde_qty", "0")) # 거래량 추가
            } for item in raw_candles
        ]
    except Exception as e:
        print(f"❌ 데이터 가공 중 에러 발생: {e}")
        processed_candles = []

    # 프론트엔드 담당자가 쓰기 좋게 정리해서 반환
    return {
        "ticker": ticker,
        "stock_info": {
            "current_price": int(quote_data.get("sel_fpr_bid", "0").replace("+", "").replace("-", "")),
            "total_ask_qty": quote_data.get("tot_sel_req"),
            "total_bid_qty": quote_data.get("tot_buy_req")
        },
        "candles": processed_candles
    }
