from __future__ import annotations

from fastapi import FastAPI, HTTPException, Query

from config import CONFIG
from app.kiwoom.ws_client import KiwoomWsClient
from app.kiwoom.rest_client import issue_access_token
from app.kiwoom.condition_parser import normalize_condition_rows


app = FastAPI()

ws_client = KiwoomWsClient(CONFIG.ws_url)


# Kiwoom CNSRLST 응답을 프론트용으로 변환
def parse_conditions(resp: dict) -> list[dict]:
    data = resp.get("data") or []
    out: list[dict] = []
    for item in data:
        seq = (item.get("seq") or "").strip()
        name = (item.get("name") or "").strip()
        if seq and name:
            out.append({"id": seq, "name": name})
    return out

@app.on_event("startup")
async def startup():
    # 1) OAuth 토큰 발급
    token = await issue_access_token()

    # 2) WS 연결 + 로그인
    await ws_client.connect_and_login(token)


@app.on_event("shutdown")
async def shutdown():
    await ws_client.disconnect()


# 조건식 목록 조회 API
@app.get("/api/v1/market/conditions")
async def get_conditions():
    try:
        raw = await ws_client.request("CNSRLST", payload={}, timeout=5.0)
        if raw.get("return_code") != 0:
            raise RuntimeError(raw.get("return_msg") or "조건식 목록 조회 실패")
        return {"conditions": parse_conditions(raw)}
    except Exception as e:
        raise HTTPException(status_code=502, detail=str(e))

# 조건검색식 조회 API
@app.get("/api/v1/market/condition-search")
async def condition_search(
    condition_id: str = Query(..., description="조건검색식 번호(seq). CNSRLST의 seq 값"),
    stex_tp: str = Query("K", description="거래소구분. 문서: K=KRX"),
):
    try:
        seq = str(condition_id).strip()

        all_rows = []
        cont_yn = "N"
        next_key = ""

        while True:
            payload = {
                "seq": seq,
                "search_type": "0",
                "stex_tp": stex_tp,
                "cont_yn": cont_yn,
                "next_key": next_key,
            }

            raw = await ws_client.request("CNSRREQ", payload=payload, timeout=5.0)
            if raw.get("return_code") != 0:
                msg = raw.get("return_msg") or "조건검색 실패"
                # 키움 메시지에 "존재하지 않는 일련번호"가 포함되면 클라이언트 입력 오류로 간주
                if "존재하지 않는 일련번호" in msg:
                    raise HTTPException(status_code=400, detail=msg)
                raise RuntimeError(msg)
        
            rows = raw.get("data") or []
            if rows:
                all_rows.extend(rows)

            cont_yn = str(raw.get("cont_yn") or "N").strip()
            next_key = str(raw.get("next_key") or "").strip()

            if cont_yn != "Y":
                break

        return {
            "condition_id": seq,
            "count": len(all_rows),
            "items": normalize_condition_rows(all_rows),
        }

    except Exception as e:
        raise HTTPException(status_code=502, detail=str(e))