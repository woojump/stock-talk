import asyncio
from fastapi import APIRouter, Query, HTTPException
from app.services.news_service import news_service
# 팀원분이 구현한 KiwoomService 인스턴스를 가져옵니다
from app.services.kiwoom import kiwoom_service 
from app.core.config import settings
from langchain_openai import ChatOpenAI

router = APIRouter()

# 요약 전용 LLM 초기화 (에이전트보다 가볍게 설정)
summary_llm = ChatOpenAI(
    model=settings.MODEL_NAME,
    api_key=settings.OPENAI_API_KEY,
    temperature=0.3
)

# AI 요약 함수
async def generate_ai_summary(content: str) -> str:
    """뉴스 본문을 분석하여 3줄 요약 및 인사이트 생성"""
    if not content or len(content) < 150:
        return "본문 내용이 충분하지 않아 요약을 생성할 수 없습니다."

    prompt = f"""
    당신은 주식 투자자를 돕는 전문 금융 애널리스트입니다.
    제공된 뉴스 본문을 읽고 투자자가 빠르게 사실을 파악할 수 있도록 요약하세요.

    [작성 규칙]
    1. 핵심 내용을 최대 3줄로 요약할 것.
    2. 각 줄은 반드시 개조식으로 작성하며, 문장은 '~함', '~임' 형태로 끝낼 것.
    3. 기사에 명시적으로 언급된 사실만 사용하고, 해석·추정·권유·평가는 하지 말 것.
    4. '호재', '악재', '추천', '전망', '기대', '유망' 등 판단을 유도하는 표현은 사용하지 말 것.
    5. 실적, 수익률, 자금 규모, 사업 변화, 정책·규제, 산업 동향 등 투자 판단에 참고할 수 있는 요소가 있다면 사실 중심으로 마지막 줄에 정리할 것.

    [출력 형식]
    - 각 줄은 '-'로 시작할 것.
    - 불필요한 서론, 결론, 부연 설명은 작성하지 말 것.

    뉴스 본문:
    {content[:2500]}  # 최대 토큰을 고려한 본문 슬라이싱
    """
    
    try:
        response = await summary_llm.ainvoke(prompt)
        return response.content
    except Exception as e:
        return f"AI 요약 도중 오류가 발생했습니다: {str(e)}"


# --- [API 엔드포인트] ---

@router.get("/popular")
async def get_popular_news():
    """
    [메인 페이지] 인기 종목 기반 뉴스 큐레이션
    '많이 보는 종목' 5개 종목에 대한 뉴스를 2개씩 가져옵니다.
    """
    # 1. '인기 종목 TOP 5' 데이터 호출 (당일 누적)
    popular_stocks = await kiwoom_service.get_popular_stocks(qry_tp='4')

    if not popular_stocks:
        fallback_news = await news_service.fetch_unique_news(query="주식 시황", display=5)
        return {
            "target_stocks": [],
            "news": fallback_news
        }

    # 2. 각 종목별로 뉴스 2개씩 가져오는 비동기 작업 리스트 생성
    # 상위 5개 종목을 대상으로 합니다.
    tasks = [
        news_service.fetch_news(query=stock['name'], display=2) 
        for stock in popular_stocks[:5]
    ]
    
    # 3. 모든 종목의 뉴스 검색을 병렬로 실행
    results = await asyncio.gather(*tasks)
    
    # 4. 결과 리스트 합치기 (Flatten)
    combined_news = []
    for i, stock_news in enumerate(results):
        stock_name = popular_stocks[i]['name']
        for news_item in stock_news:
            # 어느 종목 뉴스인지 알 수 있도록 정보 추가
            news_item["stock_name"] = stock_name
            combined_news.append(news_item)
    
    # 5. 최신순 정렬 (선택 사항)
    # combined_news.sort(key=lambda x: x['pubDate'], reverse=True)

    return {
        "target_stocks": [s['name'] for s in popular_stocks[:5]],
        "news": combined_news
    }


@router.get("/stock")
async def get_stock_news(name: str = Query(..., description="종목명")):
    """[상세 페이지] 특정 종목 관련 뉴스 10개 조회"""
    return await news_service.fetch_unique_news(query=name, display=10)

@router.get("/detail")
async def get_news_detail(url: str = Query(..., description="기사 원문 URL")):
    """[뉴스 상세] 기사 클릭 시 전문 스크래핑 및 AI 요약 준비 단계"""
    article_data = news_service.get_article_content(url)
    
    if article_data["status"] == "error":
        raise HTTPException(status_code=400, detail=article_data["message"])
    
    return article_data

@router.get("/summarize")
async def get_news_summary(url: str = Query(..., description="기사 원문 URL")):
    """
    [뉴스 상세 - STEP 2] AI 요약 생성
    - 본문을 읽고 요약을 생성하여 반환합니다. (시간 소요됨)
    """
    article_data = news_service.get_article_content(url)
    
    if article_data["status"] == "error":
        return {"ai_summary": "기사 본문을 가져올 수 없어 요약에 실패했습니다."}
        
    summary = await generate_ai_summary(article_data['content'])
    return {"ai_summary": summary}