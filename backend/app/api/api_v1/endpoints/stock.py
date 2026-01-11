from __future__ import annotations

import asyncio
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Set, Tuple

import httpx
from fastapi import APIRouter, Header, HTTPException, Query
from app.services.kiwoom import kiwoom_service
from app.services.data_portal import data_portal_service

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


# 1.3 종목 상세 및 차트 - 주혁
@router.get("/stock/{ticker}/chart")
async def get_stock_chart(ticker: str):
    data = await kiwoom_service.get_market_data(f"/v1/market/chart/{ticker}")
    return data