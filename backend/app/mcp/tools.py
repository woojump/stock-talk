# backend/app/mcp/tools.py
from langchain_core.tools import tool  # 랭체인용 도구 도장
from app.services.kiwoom import kiwoom_service

# 1. 함수를 register_tools 밖으로 꺼냅니다. (그래야 import가 가능함)
@tool
async def get_top_movers(market_type: str = "상승") -> str:
    """
    주식 시장의 상위 종목들을 조회합니다.
    market_type: '상승' 또는 '하락'
    """
    sort_tp = "1" if market_type == "상승" else "3"
    
    data = await kiwoom_service.get_top_movers(sort_tp=sort_tp)
    if not data:
        return f"현재 {market_type} 종목 데이터를 가져올 수 없습니다."
    
    title = f"📈 실시간 {market_type} TOP 5"
    lines = [f"{i+1}. {s['name']}: {s['rate']}% ({s['price']}원)" for i, s in enumerate(data[:5])]
    
    return f"{title}\n" + "\n".join(lines)

@tool
async def get_popular_stocks() -> str:
    """현재 거래 대금이나 검색량이 많은 인기 종목 리스트를 가져옵니다."""
    data = await kiwoom_service.get_popular_stocks()
    if not data: return "인기 종목 정보가 없습니다."
    
    lines = [f"- {s['name']} ({s['code']})" for s in data[:5]]
    return "🔥 실시간 인기 종목\n" + "\n".join(lines)

# 3. 투자자별 순위 (외국인/기관 매수세)
@tool
async def get_investor_rank(action_type: str = "매수", investor_type: str = "기관") -> str:
    """
    장중 투자자별 매매 상위 종목을 조회합니다.
    action_type: '매수' 또는 '매도' (기본값 '매수')
    investor_type: '기관', '외국인', '연기금' 중 선택 (기본값 '기관')
    """
    # 1. 사용자의 입력을 키움 API용 코드값으로 변환
    trde_map = {"매수": "1", "매도": "2"}
    orgn_map = {"외국인": "9000", "기관": "9999", "연기금": "6000"}
    
    trde_tp = trde_map.get(action_type, "1")
    orgn_tp = orgn_map.get(investor_type, "9999")

    # 2. 키움 서비스 호출
    data = await kiwoom_service.get_investor_rank(trde_tp=trde_tp, orgn_tp=orgn_tp)
    
    if not data:
        return f"현재 {investor_type}의 {action_type} 순위 데이터를 가져올 수 없습니다."
    
    # 3. 결과 포맷팅
    title = f"🏦 {investor_type} 실시간 {action_type} 순위 (TOP 5)"
    lines = [f"{i+1}. {s['name']} - {s['amount']}억" for i, s in enumerate(data[:5])]
    
    return f"{title}\n" + "\n".join(lines)
# 4. 종목 시세 상세 데이터
@tool
async def get_market_data(ticker: str) -> str:
    """
    특정 종목의 현재가, 전일대비, 거래량 등 상세 마켓 데이터를 조회합니다.
    ticker: 종목코드 6자리 (예: '005930')
    """
    try:
        # 1. 사용자님의 서비스 함수 규격에 맞춰 호출
        # 국내주식 현재가 시세 조회를 위해 api_id를 'ka10001'로 설정합니다.
        result = await kiwoom_service.get_market_data(
            api_id="ka10001", 
            stk_cd=ticker
        )

        # 2. 응답 데이터에서 필요한 정보 추출 (키움 API 응답 필드 기준)
        # 키움 현재가(ka10001) 응답은 보통 'output' 키 안에 들어옵니다.
        output = result.get("output", {})
        
        if not output:
            return f"❌ {ticker} 종목의 데이터를 불러오지 못했습니다. (응답 없음)"

        name = output.get("stck_nm", ticker)          # 종목명
        price = output.get("stck_prpr", "0")         # 현재가
        diff = output.get("prdy_vrss", "0")          # 전일대비
        rate = output.get("prdy_ctrt", "0")          # 전일대비율
        volume = output.get("acml_tr_pbmn", "0")     # 누적 거래대금

        return (
            f"📊 **{name} ({ticker}) 현재 시세**\n"
            f"- 현재가: {int(price):,}원\n"
            f"- 전일대비: {diff}원 ({rate}%)\n"
            f"- 거래대금: {int(volume):,}원"
        )

    except Exception as e:
        return f"🚨 시세 조회 중 에러 발생: {str(e)}"

# 5. 주식 주문 (매수/매도)
@tool
async def post_trade(ticker: str, quantity: int, price: int = 0, side: str = "buy") -> str:
    """
    주식 매수 또는 매도 주문을 실행합니다. 
    ticker: 종목코드 6자리 (예: '005930')
    quantity: 주문 수량 (정수)
    price: 주문 가격 (0 입력 시 시장가 주문, 금액 입력 시 지정가 주문)
    side: 'buy'(매수) 또는 'sell'(매도) 중 선택 (기본값 'buy')
    """
    try:
        # 1. 'side' 문자열을 서비스 함수가 이해하는 'is_buy'(bool)로 변환
        is_buy = True if side.lower() == "buy" else False
        
        # 2. 사용자님이 구현하신 KiwoomService.post_trade 호출
        # 서비스 함수의 인자 명칭(ticker, qty, price, is_buy)에 정확히 매칭합니다.
        result = await kiwoom_service.post_trade(
            ticker=ticker,
            qty=quantity,
            price=price,
            is_buy=is_buy
        )
        
        # 3. 응답 처리 및 결과 메시지 구성
        # 서비스 함수 리턴값에서 주문번호("ord_no")를 확인합니다.
        order_no = result.get("ord_no")
        
        if order_no:
            action = "매수" if is_buy else "매도"
            return f"✅ {action} 주문 성공! 종목코드: {ticker}, 수량: {quantity}주, 주문번호: {order_no}"
        else:
            # 실패 시 API 응답에 포함된 메시지(msg1)를 출력합니다.
            error_msg = result.get("msg1", "사유 알 수 없음")
            return f"❌ 주문 실패: {error_msg}"

    except Exception as e:
        return f"🚨 시스템 에러 발생: {str(e)}"
    
# 6. 주문 수정
@tool
async def amend_order(orig_ord_no: str, ticker: str, quantity: int, price: int) -> str:
    """
    기존 주식 주문을 정정(수정)합니다.
    orig_ord_no: 정정하려는 원본 주문번호
    ticker: 종목코드 6자리 (예: '005930')
    quantity: 정정할 수량
    price: 정정할 가격
    """
    try:
        # KiwoomService의 amend_order 호출
        result = await kiwoom_service.amend_order(
            orig_ord_no=orig_ord_no,
            ticker=ticker,
            qty=quantity,
            price=price
        )
        
        # 결과 처리 (API 응답 구조에 따라 성공 여부 판단)
        if result.get('rt_cd') == '0' or 'ord_no' in result:
            return f"✅ 정정 주문 전송 완료! 원주문: {orig_ord_no}, 정정코드: {ticker}, 수량: {quantity}주, 가격: {price}원"
        else:
            return f"❌ 정정 실패: {result.get('msg1', '알 수 없는 오류')}"
    except Exception as e:
        return f"🚨 정정 중 시스템 에러: {str(e)}"

# 7. 주문 취소
@tool
async def cancel_order(orig_ord_no: str, ticker: str, quantity: int = 0) -> str:
    """
    기존 주식 주문을 취소합니다.
    orig_ord_no: 취소하려는 원본 주문번호
    ticker: 종목코드 6자리 (예: '005930')
    quantity: 취소할 수량 (0으로 입력하면 미체결 잔량 전부를 취소합니다)
    """
    try:
        # KiwoomService의 cancel_order 호출
        result = await kiwoom_service.cancel_order(
            orig_ord_no=orig_ord_no,
            ticker=ticker,
            qty=quantity
        )
        
        # API 응답 결과 처리
        if result.get('rt_cd') == '0' or 'ord_no' in result:
            cancel_type = f"{quantity}주" if quantity > 0 else "잔량 전부"
            return f"✅ 취소 주문 전송 완료! 원주문: {orig_ord_no}, 종목: {ticker}, 취소수량: {cancel_type}"
        else:
            return f"❌ 취소 실패: {result.get('msg1', '알 수 없는 오류')}"
    except Exception as e:
        return f"🚨 취소 중 시스템 에러: {str(e)}"

# 8. 계좌 조회
@tool
async def get_account_balance() -> str:
    """
    내 계좌의 전체 자산 요약(총 자산, 예수금, 총 수익률)과 
    현재 보유 중인 개별 종목들의 상세 현황(수량, 수익률 등)을 조회합니다.
    """
    try:
        # KiwoomService의 get_account_balance 호출
        result = await kiwoom_service.get_account_balance()
        
        summary = result.get("summary", {})
        holdings = result.get("holdings", [])

        # 1. 요약 정보 정리
        output = [
            "📊 [계좌 자산 요약]",
            f"- 총 자산: {summary.get('total_asset', 0):,}원",
            f"- 주문 가능 현금: {summary.get('available_cash', 0):,}원",
            f"- 총 평가 손익: {summary.get('total_profit_loss', 0):,}원",
            f"- 총 수익률: {summary.get('total_return_rate', 0)}%\n",
            "📈 [보유 종목 상세]"
        ]

        # 2. 보유 종목 정보 정리
        if not holdings:
            output.append("현재 보유 중인 종목이 없습니다.")
        else:
            for item in holdings:
                output.append(
                    f"• {item['name']}({item['ticker']}): {item['quantity']}주 "
                    f"(수익률: {item['profit_loss_rate']}%, 현재가: {item['current_price']:,}원)"
                )

        return "\n".join(output)

    except Exception as e:
        return f"🚨 잔고 조회 중 에러 발생: {str(e)}"

# 2. 서버 실행 시 MCP 도구로 등록해주는 함수
def register_tools(mcp):
    # 위에서 정의한 함수를 MCP 도구로 등록합니다.
    mcp.tool()(get_top_movers)