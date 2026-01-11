from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Tuple

import httpx
from fastapi import APIRouter, Header, HTTPException, Query
from app.services.kiwoom import kiwoom_service

router = APIRouter(prefix="/api/v1/market", tags=["market"])

MAX_SEARCH_RESULTS = 10
SEARCH_CACHE_TTL = 5  # seconds: short cache to reduce repeated keystroke load

# simple in-memory cache: query -> (timestamp, results_list)
_search_cache: dict[str, tuple[float, list[dict]]] = {}

@router.get("/top-movers")
async def get_top_movers():
    # 동균님 작업 구간: 
    # 1. kiwoom_service를 이용해 키움 서버에 데이터 요청
    # 2. 결과 데이터를 Flutter가 보기 좋게 가공
    return {"message": "상승률 상위 종목 결과"}

# 1.2 종목 검색 - 지민
@router.get("/search")
async def search_condition(
    query: str = Query(..., description="검색어 (종목명 또는 티커 일부)")
):
    """
    종목 키워드 검색 (Stock Search)
    - Endpoint: GET https://apis.data.go.kr/1160100/service/GetKrxListedInfoService/getItemInfo
    - Query: query=삼성
    이 엔드포인트는 Kiwoom REST API에 질의하여 검색어가 포함된 종목 리스트를 가져오고,
    최대 `MAX_SEARCH_RESULTS`(현재 10)개로 결과를 제한하여 반환합니다.
    반환 스키마는 `StockSearchResponse`와 유사합니다.
    """


# 1.3 종목 상세 및 차트 - 주혁
@router.get("/stock/{ticker}/chart")
async def get_stock_chart(ticker: str):
    data = await kiwoom_service.get_market_data(f"/v1/market/chart/{ticker}")
    return data