import httpx
import os
from newspaper import Article, Config
from thefuzz import fuzz
from typing import List, Dict
from app.core.config import settings


class NewsService:
    def __init__(self):
        # .env 파일에서 키를 안전하게 로드합니다
        self.client_id = settings.NAVER_CLIENT_ID
        self.client_secret = settings.NAVER_CLIENT_SECRET
        self.naver_url = "https://openapi.naver.com/v1/search/news.json"
        
        # 주요 경제지 필터링 리스트
        self.major_media = ["한국경제", "매일경제", "연합인포맥스", "서울경제", "머니투데이"]

    async def fetch_news(self, query: str, display: int = 10) -> List[Dict]:
        """네이버 API를 통해 뉴스를 검색하고 가공합니다."""
        headers = {
            "X-Naver-Client-Id": self.client_id,
            "X-Naver-Client-Secret": self.client_secret
        }
        params = {"query": query, "display": display, "sort": "sim"}

        async with httpx.AsyncClient() as client:
            response = await client.get(self.naver_url, headers=headers, params=params)
            if response.status_code != 200:
                return []
            
            items = response.json().get("items", [])
            results = []
            for item in items:
                # <b> 태그 제거 및 따옴표 정제
                title = item['title'].replace("<b>", "").replace("</b>", "").replace("&quot;", '"')
                description = item['description'].replace("<b>", "").replace("</b>", "").replace("&quot;", '"')
                
                results.append({
                    "title": title,
                    "link": item['originallink'] or item['link'],
                    "description": description,
                    "pubDate": item['pubDate']
                })
            return results

    async def fetch_unique_news(self, query: str, display: int = 10, similarity_threshold: int = 70) -> List[Dict]:
        """
        검색 결과에서 유사한 제목의 기사를 제거하고 고유한 기사만 반환합니다.
        """
        # 1. 중복 제거를 위해 요청량보다 2배 정도 넉넉하게 가져옵니다.
        raw_news = await self.fetch_news(query=query, display=display * 2)

        unique_news = []
        for item in raw_news:
            if len(unique_news) >= display:
                break
            
            # 2. 기존에 선정된 기사들과 제목 유사도 비교
            is_duplicate = False
            for existing in unique_news:
                # 제목 유사도가 설정값(기본 70점) 이상이면 중복으로 간주
                if fuzz.token_sort_ratio(item['title'], existing['title']) > similarity_threshold:
                    is_duplicate = True
                    break
            
            if not is_duplicate:
                unique_news.append(item)
                
        return unique_news



    def get_article_content(self, url: str) -> Dict:
        """newspaper3k를 사용하여 기사 전문을 긁어옵니다"""
        try:
            # 브라우저처럼 보이게 설정 추가
            config = Config()
            config.browser_user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            config.request_timeout = 10
            
            article = Article(url, language='ko', config=config)
            article.download()
            article.parse()

            # 텍스트가 너무 짧으면 스크래핑 실패로 간주하는 로직 추가 
            if len(article.text) < 100:
                return {"status": "error", "message": "본문을 충분히 추출하지 못했습니다."}
            
            return {
                "status": "success",
                "title": article.title,
                "content": article.text,
                "top_image": article.top_image,
                "published_date": str(article.publish_date)
            }
        
        except Exception as e:
            return {"status": "error", "message": str(e)}

# 싱글톤 객체로 생성하여 다른 곳에서 임포트 가능하게 함
news_service = NewsService()