# backend/app/mcp/server.py
from fastmcp import FastMCP
from langchain_openai import ChatOpenAI
from app.mcp.tools import register_tools
from app.core.config import settings

mcp = FastMCP("StockTalk-Mini-Agent")

# 도구 등록
register_tools(mcp)

@mcp.tool()
async def ask_stock_ai(question: str) -> str:
    """주식 시장에 대해 궁금한 점을 최신 모델에게 물어봅니다."""
    
    # 가성비 끝판왕 gpt-4o-mini 모델 사용
    llm = ChatOpenAI(
        model="gpt-4o-mini", 
        api_key=settings.OPENAI_API_KEY,
        temperature=0
    )
    
    response = await llm.ainvoke(question)
    return response.content

if __name__ == "__main__":
    mcp.run()