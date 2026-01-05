from __future__ import annotations

import os
from typing import Any

from dotenv import load_dotenv
from pydantic import BaseModel, Field

load_dotenv()


class Configuration(BaseModel):
    # ---------- Kiwoom REST ----------
    rest_base_url: str = Field(default="https://mockapi.kiwoom.com")
    rest_api_prefix: str = Field(default="/openapi/rest/v1")

    # ---------- Kiwoom WebSocket ----------
    ws_url: str = Field(default="wss://mockapi.kiwoom.com:10000/api/dostk/websocket")

    # ---------- OAuth ----------
    oauth_token_path: str = Field(default="/oauth2/token")

    # ---------- 인증 ----------
    appkey: str = Field(default="")
    secretkey: str = Field(default="")
    access_token: str = Field(default="")  # WS LOGIN용 (런타임에 발급받음)

    # ---------- 타임아웃 ----------
    ws_login_timeout: float = Field(default=5.0)
    ws_request_timeout: float = Field(default=3.0)
    rest_timeout: float = Field(default=10.0)

    # 환경변수로 덮어쓸 값들 수집
    @classmethod
    def _collect_env_overrides(cls) -> dict[str, Any]:
        overrides: dict[str, Any] = {}
        for field_name in cls.model_fields:
            env_key = field_name.upper()
            if env_key in os.environ and os.environ[env_key] != "":
                overrides[field_name] = os.environ[env_key]
        return overrides

    # 기본값 + 환경변수 override
    @classmethod
    def from_env(cls) -> "Configuration":
        return cls(**cls._collect_env_overrides())

    # ---------- helper ----------
    def build_rest_url(self, path: str, *, use_prefix: bool = True) -> str:
        """
        REST 호출 URL 생성
        - use_prefix=True: rest_base_url + rest_api_prefix + path
        - use_prefix=False: rest_base_url + path  (oauth 같은 예외 경로 대비)
        """
        base = self.rest_base_url.rstrip("/")
        pfx = self.rest_api_prefix.strip("/")
        p = path.lstrip("/")

        if use_prefix:
            return f"{base}/{pfx}/{p}"
        return f"{base}/{p}"

    def oauth_token_url(self) -> str:
        # oauth가 prefix 밖일 가능성 대비: use_prefix=False로 둠
        return self.build_rest_url(self.oauth_token_path, use_prefix=False)

CONFIG = Configuration.from_env()