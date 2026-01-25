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
async def get_market_data(stock_name: str) -> str:
    """특정 종목의 현재가, 시가, 고가, 저가 등 상세 마켓 데이터를 조회합니다."""
    stock_code = await kiwoom_service.get_code_by_name(stock_name) # 종목명->코드 변환 필요
    if not stock_code: return f"'{stock_name}'을 찾을 수 없습니다."
    
    data = await kiwoom_service.get_market_data(api_id="현재가조회", stk_cd=stock_code)
    return f"📊 {stock_name} 상세 데이터\n- 현재가: {data['price']}원\n- 전일대비: {data['diff']}%\n- 거래량: {data['volume']}"

# 5. 주식 주문 (매수/매도)
@tool
async def post_trade(stock_name: str, quantity: int, price: int = 0) -> str:
    """실제로 주식을 매수하거나 매도합니다. 반드시 사용자의 최종 확인을 받은 후 실행하세요."""
    stock_code = await kiwoom_service.get_code_by_name(stock_name)
    if not stock_code: return f"'{stock_name}' 종목 코드를 찾을 수 없습니다."
    
    result = await kiwoom_service.post_trade(ticker=stock_code, qty=quantity, price=price)
    return f"✅ 주문 완료: {stock_name} {quantity}주 ({result['order_no']})"

# 2. 서버 실행 시 MCP 도구로 등록해주는 함수
def register_tools(mcp):
    # 위에서 정의한 함수를 MCP 도구로 등록합니다.
    mcp.tool()(get_top_movers)