# app/services/kiwoom.py

import httpx
import json
from typing import Dict, Any, Optional
from app.core.config import settings


class KiwoomService:
    def __init__(self):    
        self.base_url = "https://mockapi.kiwoom.com" # 실제 주소로 변경 필요
        # 클라이언트를 한 번 생성해서 서비스 내내 재사용합니다. (성능 최적화)
        self.client = httpx.AsyncClient(base_url=self.base_url, timeout=15.0) # 클라이언트 재사용
        self.access_token = None # 서버가 관리하는 공용 토큰
   
    async def refresh_token(self) -> str:
        """공용 키로 새 토큰을 받아옵니다."""
        endpoint = "/oauth2/token"
        payload = {
            "grant_type": "client_credentials",
            "appkey": settings.KIWOOM_APP_KEY,
            "secretkey": settings.KIWOOM_APP_SECRET
        }
        # 키움 가이드에 따라 Content-Type 명시
        headers = {"Content-Type": "application/json;charset=UTF-8"}
    
        response = await self.client.post(endpoint, json=payload, headers=headers)
        res_json = response.json()
        
        # 1. 토큰 추출
        self.access_token = res_json.get("token")

        # 토큰이 성공적으로 발급된 경우 (return_code 0)
        if res_json.get("return_code") == 0 and self.access_token:
            print(f"✅ [DEBUG] 토큰 발급 성공! (만료: {res_json.get('expires_dt')})")
            print(f"✅ [DEBUG] 토큰: {self.access_token[:20]}...") 
            return self.access_token
        else:
            # 실패한 경우 에러 메시지 출력
            print(f"❌ [DEBUG] 토큰 발급 실패! 키움 응답: {res_json}")
            return ""
    

    async def get_market_data(self, api_id: str, stk_cd: str, cont_yn: str = 'N', next_key: str = '') -> Dict[str, Any]:
        """시세 조회, 조건 검색 등 데이터를 가져올 때 사용 (GET)"""
        if not self.access_token:
            await self.refresh_token()

        endpoint = "/api/dostk/mrkcond" # 시세 조회 공통 엔드 포인트
        headers = {
            "Content-Type": "application/json; charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": api_id,       # 예: 'ka10004'
            "cont-yn": cont_yn,
            "next-key": next_key
        }

        # Body 데이터 (종목코드 등)
        data = {"stk_cd": stk_cd}

        response = await self.client.post(endpoint, headers=headers, json=data)
        
        # 토큰 만료 시 재시도
        if response.status_code == 401:
            await self.refresh_token()
            headers["authorization"] = f"Bearer {self.access_token}"
            response = await self.client.post(endpoint, headers=headers, json=data)

        response.raise_for_status()
        return response.json()

        

    async def post_trade(self, ticker: str, qty: int, price: int = 0) -> Dict[str, Any]:
        """매수, 매도, 계좌 인증 등 데이터를 보낼 때 사용 (POST)"""
        
        # 1. 토큰이 없으면 새로 받아오기
        if not self.access_token:
            await self.refresh_token()

        endpoint = "/api/dostk/ordr" 
        headers = {
            'Content-Type': 'application/json;charset=UTF-8',
            "authorization": f"Bearer {self.access_token}",
            'api-id': 'kt10000', # 매수 주문 TR ID
        }
        
        # 2. 키움 규격에 맞는 데이터 구성 (계좌번호/비밀번호 삭제!)
        payload = {
            'dmst_stex_tp': 'KRX',    # 국내거래소구분
            'stk_cd': ticker,         # 종목코드
            'ord_qty': str(qty),      # 주문수량
            'ord_uv': str(price) if price > 0 else "", # 주문단가 (시장가면 공백)
            'trde_tp': '3' if price == 0 else '0',    # 3:시장가, 0:보통(지정가)
            'cond_uv': ''             # 조건단가
    }

        # 3. 키움 서버로 주문 전송
        response = await self.client.post(endpoint, headers=headers, json=payload)
        return response.json()

    async def close(self):
        """서버 종료 시 연결을 안전하게 닫습니다."""
        await self.client.aclose()

# 싱글톤 인스턴스 생성
kiwoom_service = KiwoomService()