# backend/check_agent.py
import asyncio
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent  # ✅ 최신 표준 방식
from langchain_core.tools import tool

from app.core.config import settings
from app.services.kiwoom import kiwoom_service

from app.mcp.tools import (
    get_top_movers, 
    get_popular_stocks, 
    get_investor_rank, 
    get_market_data, 
    post_trade,
    amend_order,
    cancel_order,
    get_account_balance
)

async def main():
    # 1. 모델 설정 (온도를 0으로 낮춰서 주식 데이터의 정확성을 높입니다)
    llm = ChatOpenAI(
        model=settings.MODEL_NAME, 
        api_key=settings.OPENAI_API_KEY,
        temperature=0  # AI가 헛소리하지 않고 팩트만 말하게 함
    )

    # 2. 도구 리스트 등록 (tools.py에서 가져온 모든 함수를 리스트에 담기)
    # 이 리스트에 있는 함수들을 에이전트가 상황에 맞춰 골라 씁니다.
    tools = [
        get_top_movers, 
        get_popular_stocks, 
        get_investor_rank, 
        get_market_data, 
        post_trade,
        amend_order,
        cancel_order,
        get_account_balance
    ]

    # 3. 최신 LangGraph 에이전트 생성
    app = create_react_agent(llm, tools)

    print("🚀 모든 주식 도구가 장착된 에이전트가 준비되었습니다.")

    # 4. 테스트 질문 (에이전트의 사고력을 테스트할 수 있는 복합 질문)
    query = "005930 종목 1주 사봐"
    print(f"질문: {query}\n")

    # 5. 실행 및 스트리밍 출력
    inputs = {"messages": [HumanMessage(content=query)]}
    
    # astream을 쓰면 에이전트가 어떤 도구를 호출하는지 실시간으로 볼 수 있습니다.
    async for event in app.astream(inputs, stream_mode="values"):
        # 메시지 히스토리 중 가장 최근의 메시지(AI 답변)를 가져옴
        final_answer = event["messages"][-1]
    
    print("-" * 50)
    print(f"🤖 에이전트 답변:\n{final_answer.content}")

if __name__ == "__main__":
    asyncio.run(main())