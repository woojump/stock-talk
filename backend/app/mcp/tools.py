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
        print(f"🔍 [시세조회] 입력된 티커: {ticker}")
        ticker_formatted = ticker.zfill(6)
        
        result = await kiwoom_service.get_market_data(
            api_id="ka10001", 
            stk_cd=ticker_formatted
        )

        print(f"📦 [API 응답]: {result}")

        # 1. 응답 데이터에서 실제 필드값 추출 (보내주신 로그 기준)
        # 데이터가 'output'에 담겨오지 않고 바로 result에 있으므로 result.get 사용
        name = result.get("stk_nm", ticker_formatted)
        price = result.get("cur_prc", "0")      # 현재가
        diff = result.get("pred_pre", "0")      # 전일대비 (변동액)
        rate = result.get("flu_rt", "0")        # 등락률
        volume = result.get("trde_qty", "0")    # 거래량

        # 2. 부호(+, -) 제거 및 숫자 포맷팅
        # 데이터가 '-160500' 처럼 오기 때문에 부호를 떼고 계산해야 함
        clean_price = str(price).replace('-', '').replace('+', '')
        clean_diff = str(diff).replace('-', '').replace('+', '')

        try:
            formatted_price = f"{int(clean_price):,}원"
            formatted_volume = f"{int(volume):,}주" # 거래량 단위는 '주'가 적절
        except (ValueError, TypeError):
            formatted_price = f"{price}원"
            formatted_volume = f"{volume}주"

        # 3. 등락 상태에 따른 아이콘 (선택사항이지만 넣으면 예쁨)
        icon = "▲" if "+" in str(price) or float(rate) > 0 else "▼"
        if float(rate) == 0: icon = "〓"

        return (
            f"📊 **{name} ({ticker_formatted}) 현재 시세**\n"
            f"- 현재가: {formatted_price}\n"
            f"- 전일대비: {icon} {clean_diff}원 ({rate}%)\n"
            f"- 거래량: {formatted_volume}"
        )

    except Exception as e:
        print(f"🚨 [도구 에러]: {str(e)}")
        return f"🚨 시세 조회 중 파싱 에러가 발생했습니다: {str(e)}"
    
@tool
async def search_stock_ticker(query: str) -> str:
    """
    사용자가 입력한 종목명(예: 삼성전자, 현대차)으로 종목 코드(티커)를 찾습니다.
    시세 조회나 주문 전 단계에서 반드시 이 도구를 사용해 코드를 먼저 확인해야 합니다.
    """
    try:
        # 기존에 만들어두신 finance_data_service의 search 기능을 활용합니다.
        from app.api.api_v1.endpoints.stock import finance_data_service # 임포트 체크 필요
        
        results = finance_data_service.search(query)
        
        if not results:
            return f"'{query}'에 해당하는 종목을 찾을 수 없습니다. 정확한 이름을 입력해 주세요."
        
        # 검색 결과 중 첫 번째 종목의 정보를 에이전트에게 전달
        top_match = results[0]
        return f"검색 결과: {top_match['name']}의 종목 코드는 {top_match['ticker']}입니다."
    
    except Exception as e:
        return f"종목 검색 중 오류 발생: {str(e)}"

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
        print(f"💰 [잔고 응답 데이터]: {result}") # 이 로그를 확인해야 합니다!
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
    mcp.tool()(get_popular_stocks)
    mcp.tool()(get_investor_rank)
    mcp.tool()(get_market_data)
    mcp.tool()(search_stock_ticker)
    mcp.tool()(post_trade)        # <--- 매수/매도 주문 필수!
    mcp.tool()(amend_order)       # 주문 정정
    mcp.tool()(cancel_order)      # 주문 취소
    mcp.tool()(get_account_balance) # 계좌 조회
