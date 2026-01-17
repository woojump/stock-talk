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

# 2. 서버 실행 시 MCP 도구로 등록해주는 함수
def register_tools(mcp):
    # 위에서 정의한 함수를 MCP 도구로 등록합니다.
    mcp.tool()(get_top_movers)