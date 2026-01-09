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
            "appsecret": settings.KIWOOM_APP_SECRET
        }
        # 키움 가이드에 따라 Content-Type 명시
        headers = {"Content-Type": "application/json;charset=UTF-8"}

        # 실제 키움 토큰 발급
        response = await self.client.post(endpoint, json=payload, headers=headers)
        response.raise_for_status()

        self.access_token = response.json().get("access_token")
        return self.access_token

    # 전일대비등락률상위요청
    async def get_top_movers(self, sort_tp: str = '1'):
            """
            전일대비등락률 상위 요청 (기존 fn_ka10027 로직 이식)
            sort_tp: '1'(상승률), '3'(하락률)
            """
            # 1. 토큰이 없으면 자동으로 갱신 로직 호출
            if not self.access_token:
                await self.refresh_token()

            endpoint = '/api/dostk/rkinfo'
            
            # 2. 헤더 및 요청 데이터 설정 (기존 fn_ka10027 내용)
            headers = {
                'Content-Type': 'application/json;charset=UTF-8',
                'authorization': f'Bearer {self.access_token}',
                'api-id': 'ka10027',
            }

            params = {
                'mrkt_tp': '000',
                'sort_tp': sort_tp,  # 매개변수로 상승/하락 결정
                'trde_qty_cnd': '0000',
                'stk_cnd': '0',
                'crd_cnd': '0',
                'updown_incls': '1',
                'pric_cnd': '0',
                'trde_prica_cnd': '0',
                'stex_tp': '3',
            }

            # 3. 비동기 POST 요청 (requests 대신 클래스의 self.client 사용)
            response = await self.client.post(endpoint, headers=headers, json=params)
            response.raise_for_status() # 에러 발생 시 예외 처리

            res_json = response.json()
            items = res_json.get('pred_pre_flu_rt_upper', [])

            # 4. 결과 가공 (print 대신 리스트에 담아 return)
            top_5 = []
            for stock in items[:5]:
                top_5.append({
                    "name": stock.get('stk_nm', 'N/A'),
                    "rate": stock.get('flu_rt', '0'),
                    "price": stock.get('cur_prc', '0')
                })
            
            return top_5
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

    async def post_trade(self, ticker: str, qty: int, is_buy: bool, is_market_price: bool = True) -> Dict[str, Any]:
        """매수, 매도, 계좌 인증 등 데이터를 보낼 때 사용 (POST)"""
        
        # 1. 토큰이 없으면 새로 받아오기
        if not self.access_token:
            await self.refresh_token()

        endpoint = "/api/dostk/ordr" 
        headers = {
            "authorization": f"Bearer {self.access_token}",
            "Content-Type": "application/json; charset=UTF-8"
        }
        
        # 2. 주문 데이터 구성 (공용 계좌번호 자동으로 포함!)
        payload = {
            "cano": settings.KIWOOM_ACCOUNT_NO,      # 계좌번호 (8자리)
            "acpt_m_pwd": settings.KIWOOM_ACCOUNT_PWD, # 계좌비밀번호 (4자리, .env에 추가 필요)
            "pdno": ticker,                          # 종목번호
            "ord_qty": str(qty),                     # 주문수량 (문자열 요구할 수 있음)
            "ord_unpr": "0",                         # 시장가면 0
            "tr_dv": "01" if is_buy else "02",        # 01:매수, 02:매도
            "ord_dv": "03" if is_market_price else "00" # 03:시장가, 00:지정가
        }

        # 3. 키움 서버로 주문 전송
        response = await self.client.post(endpoint, headers=headers, json=payload)
        return response.json()

    async def close(self):
        """서버 종료 시 연결을 안전하게 닫습니다."""
        await self.client.aclose()

# 싱글톤 인스턴스 생성
kiwoom_service = KiwoomService()