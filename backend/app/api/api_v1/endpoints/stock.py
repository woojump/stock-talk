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