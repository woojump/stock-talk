from __future__ import annotations

import time
import re
import httpx
import os
from newspaper import Article, Config
from thefuzz import fuzz
from typing import List, Dict, Any, Optional, Tuple
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

    async def get_stock_news_items_for_chat(
        self,
        stock_name: str,
        limit: int = 8,
        similarity_threshold: int = 70,
    ) -> List[Dict[str, Any]]:
        """
        채팅 툴에서 쓰기 좋은 '표준 뉴스 아이템'으로 반환
        반환 예시:
        [
          {"news_id":"0", "title":"...", "publisher":"한국경제", "published_at":"...", "url":"..."},
          ...
        ]
        """
        stock_name = (stock_name or "").strip()
        if not stock_name:
            return []

        items = await self.fetch_unique_news(
            query=stock_name,
            display=limit,
            similarity_threshold=similarity_threshold,
        )

        out: List[Dict[str, Any]] = []
        for idx, it in enumerate(items):
            url = it.get("link") or ""
            title = it.get("title") or ""
            pub = it.get("pubDate") or ""
            publisher = self._guess_publisher_from_title_or_desc(
                title=title,
                description=it.get("description") or "",
            )
            out.append(
                {
                    "news_id": str(idx),     # ✅ url이 더 안정적이면 url을 넣어도 됨
                    "title": title,
                    "publisher": publisher,
                    "published_at": pub,
                    "url": url,
                    "description": it.get("description") or "",
                }
            )
        return out

    def _guess_publisher_from_title_or_desc(self, title: str, description: str) -> str:
        """
        네이버 검색 API 결과만으로는 언론사가 항상 깔끔히 안 들어올 수 있어서
        아주 단순 추정(없으면 '-')
        """
        text = f"{title} {description}"
        for m in getattr(self, "major_media", []):
            if m in text:
                return m
        return "-"

    # ----------------------------
    # ✅ (추가2) 질문 기반 후보 기사 선택
    # ----------------------------
    def pick_candidates_for_chat(
        self,
        items: List[Dict[str, Any]],
        question: str,
        max_pick: int = 2,
    ) -> List[Dict[str, Any]]:
        q = (question or "").lower()

        # "왜"류면 원인 가능성 높은 키워드 우선
        if any(k in q for k in ["왜", "원인", "이유", "급등", "급락", "떨어", "하락", "상승", "올라"]):
            keywords = [
                "실적", "전망", "가이던스", "수주", "계약", "공급", "리콜", "규제", "소송",
                "금리", "환율", "공매도", "지수", "정책", "투자", "인수", "합병", "M&A",
            ]
            return self._pick_by_title_keywords(items, keywords, max_pick=max_pick)

        # 요약/핵심이면 최신순 상위
        if any(k in q for k in ["요약", "정리", "이슈", "핵심", "주요", "뉴스"]):
            return items[:max_pick]

        return items[:max_pick]

    def _pick_by_title_keywords(
        self,
        items: List[Dict[str, Any]],
        keywords: List[str],
        max_pick: int = 2,
    ) -> List[Dict[str, Any]]:
        scored: List[Tuple[int, Dict[str, Any]]] = []
        for it in items:
            title = it.get("title") or ""
            score = 0
            for kw in keywords:
                if kw in title:
                    score += 2
            scored.append((score, it))
        scored.sort(key=lambda x: x[0], reverse=True)
        picked = [it for score, it in scored if score > 0][:max_pick]
        return picked if picked else items[:max_pick]

    # ----------------------------
    # ✅ (추가3) 기사 본문에서 "근거 문장" 뽑기 (룰 기반, 매우 단순)
    # ----------------------------
    def extract_facts_from_article_text(
        self,
        article_text: str,
        question: str,
        max_facts: int = 3,
    ) -> List[Dict[str, Any]]:
        """
        LLM 없이도 동작하는 최소 버전:
        - 문장 분리
        - 질문 키워드(왜/실적/전망/수주/금리/환율 등)와 겹치는 문장 우선
        - 숫자(%, 조, 억 등)가 포함된 문장 가산점
        """
        text = (article_text or "").strip()
        if not text:
            return []

        # 아주 단순 문장 분리(한국어 완벽X, MVP용)
        sents = re.split(r"(?<=[\.\!\?])\s+|(?<=다\.)\s+|(?<=요\.)\s+", text)
        sents = [s.strip() for s in sents if len(s.strip()) >= 20]

        q = (question or "").lower()
        q_keywords = self._keywords_from_question(q)

        def score_sent(sent: str) -> int:
            sc = 0
            for kw in q_keywords:
                if kw and kw in sent:
                    sc += 2
            # 숫자/단위 포함 가산점
            if re.search(r"\d", sent):
                sc += 1
            if re.search(r"(조|억|만|%|bp|달러|원)", sent):
                sc += 1
            return sc

        scored = [(score_sent(s), s) for s in sents]
        scored.sort(key=lambda x: x[0], reverse=True)

        facts: List[Dict[str, Any]] = []
        for sc, s in scored:
            if sc <= 0:
                continue
            facts.append(
                {
                    "fact": s[:120] + ("…" if len(s) > 120 else ""),
                    "evidence": s[:200] + ("…" if len(s) > 200 else ""),
                }
            )
            if len(facts) >= max_facts:
                break

        return facts

    def _keywords_from_question(self, q_lower: str) -> List[str]:
        # 질문에 따라 키워드 세트 선택(매우 단순)
        base = []
        if any(k in q_lower for k in ["왜", "원인", "이유", "급락", "급등", "하락", "상승"]):
            base += ["실적", "전망", "수주", "계약", "금리", "환율", "규제", "소송", "리콜", "공급", "수요", "적자", "흑자"]
        if any(k in q_lower for k in ["실적", "영업이익", "매출"]):
            base += ["매출", "영업이익", "순이익", "컨센서스", "가이던스"]
        if any(k in q_lower for k in ["금리", "환율"]):
            base += ["금리", "환율", "달러", "채권"]
        if any(k in q_lower for k in ["수주", "계약"]):
            base += ["수주", "계약", "MOU", "공급"]
        # 중복 제거
        return list(dict.fromkeys(base))
    

# 싱글톤 객체로 생성하여 다른 곳에서 임포트 가능하게 함
news_service = NewsService()