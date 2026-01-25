from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Set, Tuple

import httpx
from fastapi import APIRouter, Header, HTTPException, Query
from app.services.kiwoom import kiwoom_service
from app.services.data_portal import data_portal_service

router = APIRouter(tags=["market"])
import asyncio

MAX_SEARCH_RESULTS = 10
SEARCH_CACHE_TTL = 5  # seconds: short cache to reduce repeated keystroke load

# simple in-memory cache: query -> (timestamp, results_list)
_search_cache: dict[str, tuple[float, list[dict]]] = {}

  
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
@router.get("/search")
async def search(
    query: str = Query(..., description="종목명 또는 단축코드 일부(포함 검색)"),
):
    q = (query or "").strip()
    if not q:
        return []

    results: List[Dict[str, str]] = []
    seen: Set[Tuple[str, str]] = set()  # (srtnCd, itmsNm) 중복 제거

    async with httpx.AsyncClient() as client:
        # 1) 종목명 포함 검색
        items_by_name = await data_portal_service.fetch_krx(client, like_itms_nm=q, rows=MAX_SEARCH_RESULTS)

        # 2) 단축코드 포함 검색
        items_by_code = await data_portal_service.fetch_krx(client, like_srtn_cd=q, rows=MAX_SEARCH_RESULTS)

    # 합치기(이름 결과 우선) + 필요한 필드만
    for it in (items_by_name + items_by_code):
        srtn = (it.get("srtnCd") or "").strip()
        name = (it.get("itmsNm") or "").strip()
        if not srtn or not name:
            continue

        key = (srtn, name)
        if key in seen:
            continue
        seen.add(key)

        results.append({"srtnCd": srtn, "itmsNm": name})
        if len(results) >= data_portal_service.max_search_results:
            break

    return results


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
    
    '''
    # 2. 터미널에 원본 데이터 출력 (여기가 핵심!)
    print("\n" + "="*50)
    print(f"🔍 [DEBUG] 종목코드: {ticker}")
    print(f"📈 [호가 원본(ka10004)]: {quote_data}")
    print(f"📊 [차트 원본(ka10005)]: {chart_raw}")
    print("="*50 + "\n")
    '''
    

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
