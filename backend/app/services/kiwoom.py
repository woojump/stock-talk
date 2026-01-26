# app/services/kiwoom.py

from __future__ import annotations

import httpx
import json
import os
from datetime import datetime, timedelta  # 시간 계산을 위해 추가
from typing import Dict, Any, Optional
from app.core.config import settings


class KiwoomService:
    def __init__(self):
        self.base_url = "https://mockapi.kiwoom.com"  # 실제 주소로 변경 필요
        # 클라이언트를 한 번 생성해서 서비스 내내 재사용합니다. (성능 최적화)
        self.client = httpx.AsyncClient(
            base_url=self.base_url, timeout=15.0
        )  # 클라이언트 재사용
        self.access_token = None  # 서버가 관리하는 공용 토큰
        self.token_expires_at = None  # 만료 시간을 저장할 변수 추가
        self.default_account_no = os.getenv(
            "KIWOOM_ACCOUNT_NO"
        )  # 환경변수에서 기본 계좌번호 로드

    async def get_stock_detail(self, ticker: str) -> Dict:
        """
        1.3 종목 상세 및 차트 데이터 통합 엔드포인트
        - ka10004: 실시간 호가 및 현재가 정보
        - ka10005: 캔들 차트용 일별 주가 데이터
        """
        # 1. 실시간 호가 정보 가져오기 (ka10004)
        quote_data = await self.get_market_data(api_id="ka10004", stk_cd=ticker)

        # 2. 차트 데이터 가져오기 (ka10005)
        chart_raw = await self.get_market_data(api_id="ka10005", stk_cd=ticker)

        """
        # 2. 터미널에 원본 데이터 출력 (여기가 핵심!)
        print("\n" + "="*50)
        print(f"🔍 [DEBUG] 종목코드: {ticker}")
        print(f"📈 [호가 원본(ka10004)]: {quote_data}")
        print(f"📊 [차트 원본(ka10005)]: {chart_raw}")
        print("="*50 + "\n")
        """

        # 3. 기존 가공 로직
        # (여기서 에러가 나더라도 위에서 print는 찍힙니다.)
        try:
            # 데이터가 담긴 리스트 추출 (안전하게 get 사용)
            raw_candles = chart_raw.get("stk_ddwkmm", [])

            processed_candles = [
                {
                    "time": item.get("date"),
                    # 부호(+, -)를 제거하고 정수(int)로 변환
                    "open": int(
                        item.get("open_pric", "0").replace("+", "").replace("-", "")
                    ),
                    "high": int(
                        item.get("high_pric", "0").replace("+", "").replace("-", "")
                    ),
                    "low": int(
                        item.get("low_pric", "0").replace("+", "").replace("-", "")
                    ),
                    "close": int(
                        item.get("close_pric", "0").replace("+", "").replace("-", "")
                    ),
                    "volume": int(item.get("trde_qty", "0")),  # 거래량 추가
                }
                for item in raw_candles
            ]
        except Exception as e:
            print(f"❌ 데이터 가공 중 에러 발생: {e}")
            processed_candles = []

        # 프론트엔드 담당자가 쓰기 좋게 정리해서 반환
        return {
            "ticker": ticker,
            "stock_info": {
                "current_price": int(
                    quote_data.get("sel_fpr_bid", "0").replace("+", "").replace("-", "")
                ),
                "total_ask_qty": quote_data.get("tot_sel_req"),
                "total_bid_qty": quote_data.get("tot_buy_req"),
            },
            "candles": processed_candles,
        }

    async def refresh_token(self) -> str:
        """공용 키로 새 토큰을 받아옵니다."""
        endpoint = "/oauth2/token"
        payload = {
            "grant_type": "client_credentials",
            "appkey": settings.KIWOOM_APP_KEY,
            "secretkey": settings.KIWOOM_APP_SECRET,
        }
        # 키움 가이드에 따라 Content-Type 명시
        headers = {"Content-Type": "application/json;charset=UTF-8"}

        # 실제 키움 토큰 발급
        response = await self.client.post(endpoint, json=payload, headers=headers)
        res_json = response.json()

        # 1. 토큰 추출
        self.access_token = res_json.get("token")

        if res_json.get("return_code") == 0 and self.access_token:
            # 3. 만료 시간 설정 (보통 24시간이지만 안전하게 23시간 50분으로 설정)
            self.token_expires_at = datetime.now() + timedelta(hours=23, minutes=50)
            # print(f"[DEBUG] 토큰 발급 성공! (만료 예정: {self.token_expires_at})")
            return self.access_token
        else:
            # print(f"[DEBUG] 토큰 발급 실패! 키움 응답: {res_json}")
            return ""

    async def ensure_token(self):
        """토큰이 없거나 만료되었다면 자동으로 갱신합니다."""
        # 현재 시간이 만료 5분 전이거나 토큰이 없으면 갱신
        is_expired = (
            self.token_expires_at is None or datetime.now() >= self.token_expires_at
        )

        if not self.access_token or is_expired:
            await self.refresh_token()

    # 전일대비등락률상위요청
    async def get_top_movers(self, sort_tp: str = "1"):
        """
        전일대비등락률 상위 요청 (기존 fn_ka10027 로직 이식)
        sort_tp: '1'(상승률), '3'(하락률)
        """

        await self.ensure_token()  # 변경됨

        endpoint = "/api/dostk/rkinfo"

        # 2. 헤더 및 요청 데이터 설정 (기존 fn_ka10027 내용)
        headers = {
            "Content-Type": "application/json;charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": "ka10027",
        }

        params = {
            "mrkt_tp": "000",
            "sort_tp": sort_tp,  # 매개변수로 상승/하락 결정
            "trde_qty_cnd": "0000",
            "stk_cnd": "0",
            "crd_cnd": "0",
            "updown_incls": "1",
            "pric_cnd": "0",
            "trde_prica_cnd": "0",
            "stex_tp": "3",
        }

        # 3. 비동기 POST 요청 (requests 대신 클래스의 self.client 사용)
        response = await self.client.post(endpoint, headers=headers, json=params)
        response.raise_for_status()  # 에러 발생 시 예외 처리

        res_json = response.json()
        items = res_json.get("pred_pre_flu_rt_upper", [])

        # 4. 결과 가공 (print 대신 리스트에 담아 return)
        top_5 = []
        for stock in items[:5]:

            # 현재가에서 '-' 또는 '+' 기호를 제거합니다.
            raw_price = stock.get("cur_prc", "0")
            clean_price = raw_price.replace("-", "").replace("+", "")

            top_5.append(
                {
                    "name": stock.get("stk_nm", "N/A"),
                    "rate": stock.get("flu_rt", "0"),
                    "price": clean_price,
                }
            )

        return top_5

    async def get_popular_stocks(
        self, qry_tp: str = "4", cont_yn: str = "N", next_key: str = ""
    ):
        """
        [많이 보는 TOP 5] 실시간 종목 조회 순위 요청 (ka00198)
        qry_tp: '1'(1분), '2'(10분), '3'(1시간), '4'(당일 누적), '5'(30초)
        """

        await self.ensure_token()  # 변경됨

        # 2. 요청할 API URL 및 헤더 설정
        endpoint = "/api/dostk/stkinfo"

        headers = {
            "Content-Type": "application/json;charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "cont-yn": cont_yn,
            "next-key": next_key,
            "api-id": "ka00198",
        }

        # 3. 요청 데이터 (params)
        data = {
            "qry_tp": qry_tp,
        }

        # 4. 비동기 POST 요청 실행
        response = await self.client.post(endpoint, headers=headers, json=data)

        # 원본 느낌 살린 디버깅 출력
        # print(f'Code: {response.status_code}')
        # print('Header:', {key: response.headers.get(key) for key in ['next-key', 'cont-yn', 'api-id']})

        res_json = response.json()

        # 5. 응답 데이터 가공 (많이 보는 TOP 5 추출)
        # 한투 실시간 순위 리스트 키값은 보통 'rt_all_stk_lst'입니다.
        items = res_json.get("item_inq_rank", [])

        top_5 = []
        for stock in items[:5]:
            # 현재가에서 부호(+, -)를 제거
            raw_price = stock.get("past_curr_prc", "0")
            clean_price = raw_price.replace("-", "").replace("+", "")
            top_5.append(
                {
                    "rank": stock.get("bigd_rank", "N/A"),
                    "name": stock.get("stk_nm", "N/A"),
                    "price": clean_price,  # 현재가
                    "rate": stock.get("base_comp_chgr", "0"),  # 등락률
                    "code": stock.get("stk_cd", ""),  # 종목코드(티커)
                }
            )

        return top_5

    async def get_investor_rank(self, trde_tp: str = "1", orgn_tp: str = "9999"):
        """
        [많이 사는/파는 TOP 5] 장중 투자자별 매매 상위 (ka10065)
        trde_tp: '1'(순매수), '2'(순매도)
        orgn_tp: '9000'(외국인), '9999'(기관계), '6000'(연기금) 등
        """

        await self.ensure_token()  # 변경됨

        endpoint = "/api/dostk/rkinfo"

        headers = {
            "Content-Type": "application/json;charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": "ka10065",
        }

        # 원본 params 구조 그대로 유지
        params = {
            "trde_tp": trde_tp,  # 1:순매수, 2:순매도
            "mrkt_tp": "000",  # 전체 시장
            "orgn_tp": orgn_tp,  # 투자자 구분
        }

        try:
            response = await self.client.post(endpoint, headers=headers, json=params)
            # print(f'Code: {response.status_code}') # 원본 느낌 디버깅

            res_json = response.json()

            # 한투/키움 API에서 투자자별 순위 리스트는 보통 'itms_trde_rk' 또는 'output'에 담깁니다.
            # 출력 예시가 있다면 그 키값으로 수정하면 됩니다.
            items = res_json.get("opmr_invsr_trde_upper", [])

            top_5 = []
            for stock in items[:5]:
                top_5.append(
                    {
                        "name": stock.get("stk_nm", "N/A"),
                        "net_amount": stock.get("netslmt", "0"),  # 순매수량
                        "buy_qty": stock.get("buy_qty", "0"),  # 매수량
                        "sel_qty": stock.get("sel_qty", "0"),  # 매도량
                        "code": stock.get("stk_cd", ""),  # 종목코드
                    }
                )

            return top_5

        except Exception as e:
            print(f"Error in ka10065: {e}")
            return []

    async def get_market_data(
        self,
        api_id: str,
        stk_cd: str = "",
        cont_yn: str = "N",
        next_key: str = "",
        params: Optional[Dict[str, Any]] = None,
    ) -> Dict[str, Any]:
        """시세 조회, 조건 검색 등 데이터를 가져올 때 사용 (GET)"""

        await self.ensure_token()  # 변경됨

        # 1. API ID에 따른 엔드포인트 자동 선택
        if api_id.startswith("kt"):
            endpoint = "/api/dostk/acnt"  # 계좌 관련 (kt00004, kt00018 등)
        elif api_id.startswith("ka"):
            # 기존 ka10004, ka10005 등은 원래 쓰던 mrkcond 엔드포인트 유지
            endpoint = "/api/dostk/mrkcond"
        else:
            # 주문 등 기타 기능 처리
            endpoint = "/api/dostk/order"

        headers = {
            "Content-Type": "application/json; charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": api_id,  # 예: 'ka10004'
            "cont-yn": cont_yn,
            "next-key": next_key,
        }

        # Body 데이터 결정 로직
        # params가 명시적으로 들어오면 그것을 사용하고, 아니면 stk_cd를 사용합니다.
        data = params if params else {"stk_cd": stk_cd}

        response = await self.client.post(endpoint, headers=headers, json=data)

        # 토큰 만료 시 재시도
        if response.status_code == 401:
            await self.refresh_token()
            headers["authorization"] = f"Bearer {self.access_token}"
            response = await self.client.post(endpoint, headers=headers, json=data)

        response.raise_for_status()
        return response.json()
      
      
    async def post_trade(self, ticker: str, qty: int, is_buy: bool, price: int = 0, is_market_price: bool = True) -> Dict[str, Any]:
        """키움 API를 통한 매   수/매도 주문 전송"""
        
        await self.ensure_token() # 변경됨

        endpoint = "/api/dostk/ordr"
        headers = {
            "authorization": f"Bearer {self.access_token}",
            "Content-Type": "application/json; charset=UTF-8",
        }

        # 2. 주문 데이터 구성 (공용 계좌번호 자동으로 포함!)
        payload = {
            "cano": settings.KIWOOM_ACCOUNT_NO,  # 계좌번호 (8자리)
            "acpt_m_pwd": settings.KIWOOM_ACCOUNT_PWD,  # 계좌비밀번호 (4자리, .env에 추가 필요)
            "pdno": ticker,  # 종목번호
            "ord_qty": str(qty),  # 주문수량 (문자열 요구할 수 있음)
            "ord_unpr": "0",  # 시장가면 0
            "tr_dv": "01" if is_buy else "02",  # 01:매수, 02:매도
            "ord_dv": "03" if is_market_price else "00",  # 03:시장가, 00:지정가
        }

        # 3. 키움 서버로 주문 전송
        response = await self.client.post(endpoint, headers=headers, json=payload)
        response.raise_for_status()

        res_json = response.json()

        """
        # 응답 Boby에서 주문번호("ord_no") 확인 가능
        if res_json.get("ord_no"):
            print(f"[DEBUG]주문 성공! 주문번호: {res_json.get('ord_no')}")
        """

        return res_json

    async def amend_order(
        self, orig_ord_no: str, ticker: str, qty: int, price: int
    ) -> Dict[str, Any]:
        """[정정] 주식 정정주문 (kt10002)"""

        await self.ensure_token()  # 변경됨

        headers = {
            "Content-Type": "application/json; charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": "kt10002",
        }

        # 정정 주문 전용 Body 구성
        payload = {
            "dmst_stex_tp": "KRX",
            "orig_ord_no": orig_ord_no,  # 원주문번호 (Y)
            "stk_cd": ticker,  # 종목코드 (Y)
            "mdfy_qty": str(qty),  # 정정수량 (Y)
            "mdfy_uv": str(price),  # 정정단가 (Y)
            "mdfy_cond_uv": "",  # 정정조건단가 (N)
        }

        response = await self.client.post(
            "/api/dostk/ordr", headers=headers, json=payload
        )
        response.raise_for_status()
        return response.json()

    async def cancel_order(
        self, orig_ord_no: str, ticker: str, qty: int = 0
    ) -> Dict[str, Any]:
        """[취소] 주식 취소주문 (kt10003)"""

        await self.ensure_token()  # 변경됨

        headers = {
            "Content-Type": "application/json; charset=UTF-8",
            "authorization": f"Bearer {self.access_token}",
            "api-id": "kt10003",
        }

        # 취소 주문 전용 Body 구성
        payload = {
            "dmst_stex_tp": "KRX",
            "orig_ord_no": orig_ord_no,  # 원주문번호 (Y)
            "stk_cd": ticker,  # 종목코드 (Y)
            "cncl_qty": str(qty),  # 취소수량 (Y, '0' 입력 시 잔량 전부 취소)
        }

        response = await self.client.post(
            "/api/dostk/ordr", headers=headers, json=payload
        )
        response.raise_for_status()

        return response.json()

    def _parse_num(self, val: str, is_float: bool = False):
        """키움 특유의 앞자리 0과 부호를 제거하고 숫자형으로 변환"""
        if not val or str(val).strip() == "":
            return 0.0 if is_float else 0
        cleaned = str(val).strip().replace(",", "")
        try:
            return float(cleaned) if is_float else int(cleaned)
        except ValueError:
            return 0

    async def get_account_balance(self) -> Dict[str, Any]:
        """[마이페이지] 전체 자산 요약 및 개별 종목 수익률 조회"""
        # 1. 계좌 요약(kt00004) 및 상세(kt00018) 요청 파라미터 구성
        common_params = {"cano": self.default_account_no, "dmst_stex_tp": "KRX"}

        summary_res = await self.get_market_data(
            api_id="kt00004", params={**common_params, "qry_tp": "0"}
        )
        detail_res = await self.get_market_data(
            api_id="kt00018", params={**common_params, "qry_tp": "1"}
        )

        # 2. 통합 결과 반환
        return {
            "summary": {
                "total_asset": self._parse_num(summary_res.get("aset_evlt_amt")),
                "available_cash": self._parse_num(summary_res.get("d2_entra")),
                "total_profit_loss": self._parse_num(summary_res.get("lspft_amt")),
                "total_return_rate": self._parse_num(
                    summary_res.get("lspft_rt"), is_float=True
                ),
            },
            "holdings": [
                {
                    "ticker": item.get("stk_cd", "").replace("A", ""),
                    "name": item.get("stk_nm"),
                    "quantity": self._parse_num(item.get("trde_able_qty")),
                    "purchase_price": self._parse_num(item.get("pur_pric")),
                    "current_price": self._parse_num(item.get("cur_prc")),
                    "profit_loss_rate": self._parse_num(
                        item.get("prft_rt"), is_float=True
                    ),
                }
                for item in detail_res.get("acnt_evlt_remn_indv_tot", [])
            ],
        }

    async def close(self):
        """서버 종료 시 연결을 안전하게 닫습니다."""
        await self.client.aclose()


# 싱글톤 인스턴스 생성
kiwoom_service = KiwoomService()
