from __future__ import annotations

import time
from typing import Any, Dict, Optional, Tuple

import httpx

from config import CONFIG


_cached_token: Optional[Tuple[str, float]] = None  # (access_token, expires_epoch)


async def issue_access_token() -> str:
    """
    키움 OAuth 토큰 발급
    - access_token(WS LOGIN에 쓰는 token) 반환   
    """
    global _cached_token

    # 캐시 사용
    if _cached_token and time.time() < _cached_token[1] - 10:
        return _cached_token[0]

    if not CONFIG.appkey or not CONFIG.secretkey:
        raise RuntimeError("APPKEY/SECRETKEY가 비어있음 (.env 확인)")

    url = CONFIG.oauth_token_url()
    payload = {
        "grant_type": "client_credentials",
        "appkey": CONFIG.appkey,
        "secretkey": CONFIG.secretkey,
    }

    async with httpx.AsyncClient(timeout=CONFIG.rest_timeout) as client:
        r = await client.post(url, json=payload, headers={"Content-Type": "application/json;charset=UTF-8"})

    if r.status_code // 100 != 2:
        raise RuntimeError(f"OAuth 토큰 발급 실패: {r.status_code} {r.text}")

    data: Dict[str, Any] = r.json()

    token = data.get("token")
    if not token:
        raise RuntimeError(f"토큰 응답에 token이 없음: {data}")

    # expires_dt 파싱이 애매할 수 있어서(확실하지 않음) 50분 캐시
    _cached_token = (token, time.time() + 50 * 60)
    return token
