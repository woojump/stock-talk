# backend/app/mcp/server.py
from fastmcp import FastMCP
from langchain_openai import ChatOpenAI
from app.mcp.tools import register_tools
from app.core.config import settings
from langchain_core.messages import SystemMessage, HumanMessage
import json
from app.api.api_v1.endpoints.chatting import SYSTEM_PROMPT_DICT, OUTPUT_FORMAT
mcp = FastMCP("StockTalk-Mini-Agent")

# 도구 등록
register_tools(mcp)

@mcp.tool()
async def ask_stock_ai(question: str) -> str:
    """주식 시장에 대해 궁금한 점을 최신 모델에게 물어봅니다."""
    
    # 1. 모델 설정 (지능 극대화 세팅)
    llm = ChatOpenAI(
        model="gpt-4o-2024-08-06",
        temperature=0,
        max_tokens=2000,
        model_kwargs={
            "top_p": 0.1,  # 딴소리 못하게 확률 고정
        },
        max_retries=3
    )
    
    # 2. 시스템 지침 결합
    # 딕셔너리를 텍스트로 변환하고 출력 포맷을 붙입니다.
    combined_instructions = f"""
    {json.dumps(SYSTEM_PROMPT_DICT, ensure_ascii=False)}
    
    {OUTPUT_FORMAT}
    
    위 규칙을 절대적으로 준수하여 JSON으로만 대답하세요.
    """
    
    # 3. 메시지 리스트 구성 (핵심 포인트!)
    messages = [
        SystemMessage(content=combined_instructions),
        HumanMessage(content=question)
    ]
    
    # 4. 호출 및 결과 반환
    response = await llm.ainvoke(messages)
    return response.content

if __name__ == "__main__":
    mcp.run()