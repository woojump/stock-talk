import asyncio
from fastapi import APIRouter, Query, HTTPException
from app.services.news_service import news_service
# 팀원분이 구현한 KiwoomService 인스턴스를 가져옵니다
from app.services.kiwoom import kiwoom_service 

router = APIRouter()

@router.get("/popular")
async def get_popular_news():
    """
    [메인 페이지] 인기 종목 기반 뉴스 큐레이션
    '많이 보는 종목' 5개 종목에 대한 뉴스를 2개씩 가져옵니다.
    """
    # 1. '인기 종목 TOP 5' 데이터 호출 (당일 누적)
    popular_stocks = await kiwoom_service.get_popular_stocks(qry_tp='4')
    
    if not popular_stocks:
        return await news_service.fetch_unique_news(query="주식 시황", display=5)

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
        
    # TODO: LLM 요약 함수가 완성되면 여기서 article_data['content']를 넘깁니다
    # summary = await yongbin_llm_service.generate_summary(article_data['content'])
    # article_data['ai_summary'] = summary
    
    return article_data