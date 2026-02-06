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
    model="gpt-4o-2024-08-06",
    temperature=0,
    max_tokens=1500,  # 분석 내용을 충분히 담을 수 있게 설정
    model_kwargs={
        "top_p": 0.1,  # 답변의 일관성을 극대화 (0에 가까울수록 딴소리 안 함)
        "presence_penalty": 0,
        "frequency_penalty": 0
    },
    max_retries=3  # API 실패 시 알아서 3번까지 다시 시도
)
    
    response = await llm.ainvoke(question)
    return response.content

if __name__ == "__main__":
    mcp.run()