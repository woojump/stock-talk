import os
from typing import Any, Dict, List, Set, Tuple

import httpx
from fastapi import APIRouter, HTTPException, Query


class DataPortal:
    def __init__(self):
        self.max_search_results = int(os.getenv("MAX_SEARCH_RESULTS", "10"))
        self.data_portal_key = (os.getenv("DATA_PORTAL_KEY") or "").strip()

        self.krx_iteminfo_url = (
            "https://apis.data.go.kr/1160100/service/GetKrxListedInfoService/getItemInfo"
        )

    def items_from_payload(self, payload: Dict[str, Any]) -> List[Dict[str, Any]]:
        """response.body.items.item을 list[dict]로 정규화"""
        try:
            item = payload["response"]["body"]["items"]["item"]
        except Exception:
            return []

        if item is None:
            return []
        if isinstance(item, list):
            return [x for x in item if isinstance(x, dict)]
        if isinstance(item, dict):
            return [item]
        return []


    async def fetch_krx(
        self,
        client: httpx.AsyncClient,
        *,
        like_itms_nm: str | None = None,
        like_srtn_cd: str | None = None,
        rows: int = 10,
    ) -> List[Dict[str, Any]]:
        if not self.data_portal_key:
            raise HTTPException(500, "DATA_PORTAL_KEY(.env)가 설정되지 않았습니다.")

        params: Dict[str, Any] = {
            "serviceKey": self.data_portal_key,
            "resultType": "json",
            "numOfRows": max(1, min(rows, 100)),
            "pageNo": 1,
        }
        if like_itms_nm:
            params["likeItmsNm"] = like_itms_nm
        if like_srtn_cd:
            params["likeSrtnCd"] = like_srtn_cd

        resp = await client.get(self.krx_iteminfo_url, params=params, timeout=10.0)
        resp.raise_for_status()

        data = resp.json()
        header = data.get("response", {}).get("header", {}) or {}
        if header.get("resultCode") != "00":
            raise HTTPException(
                502,
                f"KRX API 오류: {header.get('resultCode')} / {header.get('resultMsg')}",
            )

        return self.items_from_payload(data)


# 인스턴스 생성
data_portal_service = DataPortal()