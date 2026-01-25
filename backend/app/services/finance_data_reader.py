import FinanceDataReader as fdr
import pandas as pd
import time


class FinanceDataService:

    MAX_SEARCH_RESULTS = 10
    LISTING_TTL_SEC = 60 * 60  # 1시간 캐시(필요시 10분/1일 등으로 조절)

    # in-memory cache
    _listing_cache: dict[str, object] = {
        "ts": 0.0,
        "df": None,
    }

    def _load_listing_krx(self) -> pd.DataFrame:
        """
        FDR에서 KRX 종목 리스트를 가져와 표준 컬럼으로 정리.
        반환 컬럼: srtnCd(단축코드), itmsNm(종목명)
        """
        df = fdr.StockListing("KRX")

        # 보편적으로 Code, Name이 있음(환경에 따라 다를 수 있어 방어적으로 처리)
        code_col = "Code" if "Code" in df.columns else ("Symbol" if "Symbol" in df.columns else None)
        name_col = "Name" if "Name" in df.columns else ("Company" if "Company" in df.columns else None)
        if not code_col or not name_col:
            # 컬럼이 예상과 다르면 그대로 오류를 내기보다 빈 데이터로 처리(운영 안정성)
            return pd.DataFrame(columns=["srtnCd", "itmsNm"])

        out = df[[code_col, name_col]].copy()
        out.columns = ["srtnCd", "itmsNm"]

        # 문자열 정리
        out["srtnCd"] = out["srtnCd"].astype(str).str.strip()
        out["itmsNm"] = out["itmsNm"].astype(str).str.strip()

        # 결측 제거
        out = out[(out["srtnCd"] != "") & (out["itmsNm"] != "")]
        return out


    def _get_listing_cached(self) -> pd.DataFrame:
        now = time.time()
        ts = float(self._listing_cache["ts"] or 0.0)
        df = self._listing_cache["df"]

        if df is None or (now - ts) > self.LISTING_TTL_SEC:
            df = self._load_listing_krx()
            self._listing_cache["df"] = df
            self._listing_cache["ts"] = now

        return df  # type: ignore[return-value]
    
    def search(self, q: str) -> list[dict[str, str]]:
        q = (q or "").strip()
        if not q:
            return []

        df = self._get_listing_cached()
        by_name = df[df["itmsNm"].str.contains(q, case=False, na=False)]
        by_code = df[df["srtnCd"].str.contains(q, case=False, na=False)]

        results: list[dict[str, str]] = []
        seen: set[tuple[str, str]] = set()

        merged = pd.concat([by_name, by_code], ignore_index=True)
        for row in merged.itertuples(index=False):
            srtn = str(getattr(row, "srtnCd", "")).strip()
            name = str(getattr(row, "itmsNm", "")).strip()
            if not srtn or not name:
                continue
            key = (srtn, name)
            if key in seen:
                continue
            seen.add(key)
            results.append({"srtnCd": srtn, "itmsNm": name})
            if len(results) >= self.MAX_SEARCH_RESULTS:
                break
        return results

# 인스턴스 생성
finance_data_service = FinanceDataService()