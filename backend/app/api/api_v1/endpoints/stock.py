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
@router.get("/search")
async def search(query: str = Query(...)):
    return finance_data_service.search(query)

# 1.3 종목 상세 및 차트
@router.get("/stock/{query}/detail")
async def get_stock_detail(query: str):
    return await kiwoom_service.get_stock_detail(query)