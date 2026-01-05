from __future__ import annotations

import asyncio
import json
import time
from dataclasses import dataclass
from typing import Any, Dict, Optional

import websockets

from config import CONFIG


@dataclass
class PendingRequest:
    future: asyncio.Future
    created_at: float


class KiwoomWsClient:
    def __init__(self, uri: str):
        self.uri = uri
        self.ws: Optional[websockets.WebSocketClientProtocol] = None
        self.connected = False
        self.keep_running = True

        self._recv_task: Optional[asyncio.Task] = None
        self._lock = asyncio.Lock()

        # MVP: 동일 trnm 동시 요청 1개 제한
        self._pending: Dict[str, PendingRequest] = {}
        self._login_ok = asyncio.Event()

    async def connect_and_login(self, access_token: str) -> None:
        async with self._lock:
            if self.connected:
                return

            self.ws = await websockets.connect(self.uri)
            self.connected = True
            self.keep_running = True
            self._login_ok.clear()

            await self.send({"trnm": "LOGIN", "token": access_token})
            self._recv_task = asyncio.create_task(self._receive_loop())

        # 로그인 완료 대기
        try:
            await asyncio.wait_for(self._login_ok.wait(), timeout=CONFIG.ws_login_timeout)
        except asyncio.TimeoutError:
            raise RuntimeError("WS LOGIN 응답 타임아웃")

    async def disconnect(self) -> None:
        self.keep_running = False
        self.connected = False
        self._login_ok.clear()

        if self.ws:
            await self.ws.close()
            self.ws = None

        if self._recv_task:
            self._recv_task.cancel()
            self._recv_task = None

    async def send(self, message: Dict[str, Any]) -> None:
        if not self.ws or not self.connected:
            raise RuntimeError("WebSocket not connected")
        await self.ws.send(json.dumps(message))

    async def request(self, trnm: str, payload: Dict[str, Any], timeout: Optional[float] = None) -> Dict[str, Any]:
        if not timeout:
            timeout = CONFIG.ws_request_timeout

        if trnm in self._pending:
            raise RuntimeError(f"동일 TR({trnm})에 대해 이미 대기 중인 요청이 있음(MVP 제한)")

        loop = asyncio.get_running_loop()
        fut = loop.create_future()
        self._pending[trnm] = PendingRequest(future=fut, created_at=time.time())

        await self.send({"trnm": trnm, **payload})

        try:
            resp = await asyncio.wait_for(fut, timeout=timeout)
            return resp
        finally:
            self._pending.pop(trnm, None)

    async def _receive_loop(self) -> None:
        assert self.ws is not None

        while self.keep_running:
            try:
                msg = await self.ws.recv()
                data = json.loads(msg)
                trnm = data.get("trnm")

                if trnm == "PING":
                    # PING 에코
                    await self.send(data)
                    continue

                if trnm == "LOGIN":
                    if data.get("return_code") == 0:
                        self._login_ok.set()
                    else:
                        for pr in self._pending.values():
                            if not pr.future.done():
                                pr.future.set_exception(RuntimeError(f"LOGIN 실패: {data.get('return_msg')}"))
                        await self.disconnect()
                    continue

                # 요청-응답 매칭(MVP: trnm로만 매칭)
                if trnm and trnm in self._pending:
                    fut = self._pending[trnm].future
                    if not fut.done():
                        fut.set_result(data)
                else:
                    # 예: 실시간 푸시 등(원하면 큐 적재)
                    pass

            except websockets.ConnectionClosed:
                self.connected = False
                for pr in self._pending.values():
                    if not pr.future.done():
                        pr.future.set_exception(RuntimeError("WebSocket 연결 종료"))
                break
            except Exception as e:
                for pr in self._pending.values():
                    if not pr.future.done():
                        pr.future.set_exception(e)
                break
