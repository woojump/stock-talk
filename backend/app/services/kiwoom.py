# app/services/kiwoom.py

from __future__ import annotations

import httpx
import json
import os
import re

from datetime import datetime, timedelta  # 시간 계산을 위해 추가
from typing import Dict, Any, Optional, List, Tuple
from app.core.config import settings
from app.services.finance_data_reader import FinanceDataService


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
        self.finance_data = FinanceDataService()

    @staticmethod
    def _clean_ticker(ticker: str) -> str:
        """티커 코드에서 불필요한 접두사/접미사 제거"""
        if not ticker:
            return ""
        # "_AL", "_AQ" 등 접미사 제거
        if "_" in ticker:
            ticker = ticker.split("_")[0]
        # "A" 접두사 제거
        ticker = ticker.replace("A", "")
        return ticker

    def _is_exact_6digit_ticker(self, q: str) -> bool:
        q = (q or "").strip()
        return bool(re.fullmatch(r"\d{6}", q))

    def _resolve_or_candidates(self, q: str) -> Tuple[Optional[str], List[Dict[str, str]], str]:
        """
        반환:
          - resolved_ticker: 확정된 6자리 티커 (없으면 None)
          - candidates: 후보 리스트 (없으면 [])
          - reason: 'TICKER' | 'EXACT' | 'UNIQUE' | 'AMBIGUOUS' | 'NOT_FOUND'
        """
        q = (q or "").strip()
        if not q:
            return None, [], "NOT_FOUND"

        # 1) 정확히 6자리 숫자일 때만 ticker로 확정
        if self._is_exact_6digit_ticker(q):
            return q, [], "TICKER"

        # 2) 그 외(종목명/초성/부분티커/1~5자리 숫자)는 DB search로 후보 찾기
        results = self.finance_data.search(q)  # [{"srtnCd": "...", "itmsNm": "..."}]
        if not results:
            return None, [], "NOT_FOUND"
        
        exact_matches = [
            r for r in results
            if r["itmsNm"] == q
        ]

        if len(exact_matches) == 1:
            return exact_matches[0]["srtnCd"], [], "EXACT"
        
        if len(results) == 1:
            return results[0]["srtnCd"], [], "UNIQUE"

        candidates = [{"srtnCd": r["srtnCd"], "itmsNm": r["itmsNm"]} for r in results]
        return None, candidates, "AMBIGUOUS"

    async def get_stock_detail(self, q: str) -> Dict:
        """
        1.3 종목 상세 및 차트 데이터 통합 엔드포인트
        - ka10004: 실시간 호가 및 현재가 정보
        - ka10005: 캔들 차트용 일별 주가 데이터
        """

        query = (q or "").strip()
        resolved_ticker, candidates, reason = self._resolve_or_candidates(query)

        if reason == "NOT_FOUND":
            return {
                "status": "fail",
                "error": "NOT_FOUND",
                "message": f"'{query}'에 해당하는 종목을 찾지 못했습니다.",
                "query": query,
            }

        if reason == "AMBIGUOUS":
            return {
                "status": "need_clarification",
                "error": "AMBIGUOUS",
                "message": f"'{query}'는 여러 종목이 검색됩니다. 일부 결과를 보여드립니다.",
                "query": query,
                "candidates": candidates,
            }
        
        ticker = resolved_ticker  # 확정된 티커 사용

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
            "status": "success",
            "query": query,
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
                    "code": self._clean_ticker(stock.get("stk_cd", "")),
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
                    "code": self._clean_ticker(stock.get("stk_cd", "")),  # 종목코드(티커)
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
                        "code": self._clean_ticker(stock.get("stk_cd", "")),  # 종목코드
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
        if api_id == "ka10001":
            endpoint = "/api/dostk/stkinfo"   # 시세 조회 전용 엔드포인트 추가!
        elif api_id == "ka01690" or api_id.startswith("kt"): # ka01690과 kt 계열은 모두 acnt
            endpoint = "/api/dostk/acnt"
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

        # 2. Body 데이터 결정 로직
        # params가 명시적 으로 들어오면 그것을 사용하고, 아니면 기존처럼 stk_cd를 사용합니다.
        data = {"stk_cd": stk_cd}
        if params:
            data.update(params) # qry_tp, cano 등이 여기서 추가됨

        response = await self.client.post(endpoint, headers=headers, json=data)
        # 토큰 만료 시 재시도
        if response.status_code == 401:
            await self.refresh_token()
            headers["authorization"] = f"Bearer {self.access_token}"
            response = await self.client.post(endpoint, headers=headers, json=data)

        response.raise_for_status()
        return response.json()

    async def post_trade(self, ticker: str, qty: int, price: int = 0, is_buy: bool = True) -> Dict[str, Any]:
        """키움 API를 통한 매수/매도 주문 전송"""
        
        await self.ensure_token() # 변경됨

        is_market_price = (price == 0)

        endpoint = "/api/dostk/ordr" 

        headers = {
            "authorization": f"Bearer {self.access_token}",
            "Content-Type": "application/json; charset=UTF-8",
            "api-id": "kt10000" if is_buy else "kt10001"

        }

        # 2. 주문 데이터 구성
        payload = {
        "dmst_stex_tp": "KRX",
        "stk_cd": ticker,
        "ord_qty": str(qty),
        "ord_uv": str(price),
        "trde_tp": "3" if price == 0 else "0",  # <--- 시장가(3) vs 지정가(0)
        "cond_uv": ""             # 조건단가 (기본 빈값)
        }   

        # 3. 키움 서버로 주문 전송
        try:
            print(f"\n🚀 [주문 시도] {ticker} / {qty}주 / {'매수' if is_buy else '매도'} / {'시장가' if is_market_price else '지정가'}")
            
            response = await self.client.post(endpoint, headers=headers, json=payload)
            
            # 응답 상태 코드가 200이 아닐 경우 에러 발생
            if response.status_code != 200:
                print(f"❌ [API 에러] 상태 코드: {response.status_code}")
                print(f"❌ [에러 내용] {response.text}")
            
            response.raise_for_status()
            res_json = response.json()

            # [여기에 이 줄을 추가해서 전체를 다 보세요!]
            print(f"🔍 [RAW DATA] 전체 응답: {res_json}") 

            #       4. 결과 출력
            print("-" * 30)

            # 4. 결과 출력 (주석 해제 및 강화)
            print("-" * 30)
            if res_json.get("ord_no") or res_json.get("rt_cd") == "0":
                print(f"✅ [주문 성공] 주문번호: {res_json.get('ord_no')}")
                print(f"✅ [메시지]: {res_json.get('msg1')}")
            else:
                print(f"⚠️ [주문 거절] 코드: {res_json.get('rt_cd')}")
                print(f"⚠️ [사유]: {res_json.get('msg1')}")
            print("-" * 30 + "\n")

            return res_json

        except Exception as e:
            print(f"🚨 [런타임 에러] 주문 함수 실행 중 오류 발생: {str(e)}")
            return {"status": "error", "message": str(e)}

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
        """[마이페이지] 종목별 데이터를 직접 합산하여 총 평가금액, 손익금액, 수익률 산출"""
        try:
            common_params = {"cano": self.default_account_no, "dmst_stex_tp": "KRX"}
            # 1. 상세 종목 리스트(kt00018)와 기본 요약(kt00004) 호출
            summary_res = await self.get_market_data(api_id="kt00004", params={**common_params, "qry_tp": "0"})
            detail_res = await self.get_market_data(api_id="kt00018", params={**common_params, "qry_tp": "1"})

            summary_data = summary_res.get("output") or summary_res
            holdings_list = detail_res.get("acnt_evlt_remn_indv_tot") or detail_res.get("output1") or []

            # --- 직접 합산 변수 초기화 ---
            total_buy_amt = 0   # 총 매수금액 (원금)
            total_evl_amt = 0   # 총 평가금액 (현재 가치)
            
            parsed_holdings = []
            for item in holdings_list:
                qty = self._parse_num(item.get("hldg_qty") or item.get("trde_able_qty"))
                pchs_price = self._parse_num(item.get("pchs_avg_pric") or item.get("pur_pric"))
                curr_price = self._parse_num(item.get("prpr") or item.get("cur_prc"))
                
                # 종목별 금액 계산
                row_buy_amt = qty * pchs_price   # 이 종목 산 돈
                row_evl_amt = qty * curr_price   # 이 종목 현재 가치
                
                # 전체 합계에 누적
                total_buy_amt += row_buy_amt
                total_evl_amt += row_evl_amt
                
                parsed_holdings.append({
                    "ticker": self._clean_ticker(item.get("stk_cd", "")),
                    "name": item.get("stk_nm") or item.get("prdt_nm"),
                    "quantity": qty,
                    "purchase_price": pchs_price,
                    "current_price": curr_price,
                    "profit_loss_rate": self._parse_num(item.get("evlu_pfls_rt") or item.get("prft_rt"), is_float=True)
                })

            # --- 최종 요약 수치 계산 ---
            # 1. 총 평가 손익 = 총 평가금액 - 총 매수금액
            total_pnl = total_evl_amt - total_buy_amt
            
            # 2. 총 수익률 = (총 손익 / 총 매수금액) * 100
            if total_buy_amt > 0:
                final_rt = (total_pnl / total_buy_amt) * 100
            else:
                final_rt = 0.0

            # 3. 예수금 (예수금은 합산이 안 되므로 서버에서 직접 가져옴)
            available_cash = self._parse_num(summary_data.get("d2_entra") or summary_data.get("dnca_tot_amt"))

            return {
                "summary": {
                    "total_asset": total_evl_amt + available_cash, # 총 자산 = 주식평가금 + 현금
                    "stock_evaluation": total_evl_amt,            # 총 주식 평가 금액
                    "available_cash": available_cash,             # 예수금
                    "total_profit_loss": total_pnl,               # 총 평가 수익금액
                    "total_return_rate": round(final_rt, 2)       # 총 수익률
                },
                "holdings": parsed_holdings
            }

        except Exception as e:
            print(f"🚨 [잔고 합산 계산 에러]: {str(e)}")
            return {"summary": {"total_asset": 0, "available_cash": 0, "total_profit_loss": 0, "total_return_rate": 0.0}, "holdings": []}    
        
    async def close(self):
        """서버 종료 시 연결을 안전하게 닫습니다."""
        await self.client.aclose()


# 싱글톤 인스턴스 생성
kiwoom_service = KiwoomService()
