# backend/check_agent.py
import asyncio
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent  # ✅ 최신 표준 방식
from langchain_core.tools import tool

from app.core.config import settings
from app.services.kiwoom import kiwoom_service

from app.mcp.tools import get_top_movers

async def main():
    # 2. 모델 및 도구 설정
    llm = ChatOpenAI(model=settings.MODEL_NAME, api_key=settings.OPENAI_API_KEY)
    tools = [get_top_movers]

    # 3. 최신 LangGraph 에이전트 생성 (AgentExecutor 대체)
    # create_react_agent는 내부적으로 최적화된 흐름을 자동으로 생성합니다.
    app = create_react_agent(llm, tools)

    print("🚀 최신 LangGraph 에이전트가 준비되었습니다.")

    # 4. 실행
    query = "지금 상승장인거 뭐뭐 있냐염~"
    print(f"질문: {query}\n")

    # LangGraph는 메시지 리스트를 주고받는 방식입니다.
    inputs = {"messages": [HumanMessage(content=query)]}
    
    async for event in app.astream(inputs, stream_mode="values"):
        # 마지막 메시지(AI의 최종 답변)만 출력하기 위해 루프 사용
        final_answer = event["messages"][-1]
    
    print(f"🤖 최종 답변:\n{final_answer.content}")

if __name__ == "__main__":
    asyncio.run(main())