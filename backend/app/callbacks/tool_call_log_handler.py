import json
import time
from datetime import datetime
from typing import Any, Dict, Optional

from langchain_core.callbacks import BaseCallbackHandler


def _tool_type_from_name(tool_name: str) -> str:
    trade_tools = {"post_trade", "amend_order", "cancel_order"}
    read_tools = {
        "get_top_movers",
        "get_popular_stocks",
        "get_investor_rank",
        "get_market_data",
        "get_account_balance",
    }

    if tool_name in trade_tools:
        return "trade"
    if tool_name in read_tools:
        return "read"
    return "read"


class ToolCallLogHandler(BaseCallbackHandler):
    """
    pymysql 기반으로 tool_call_log 테이블 기록
    - on_tool_start: INSERT (tool_call_id 확보)
    - on_tool_end: UPDATE success
    - on_tool_error: UPDATE error
    """

    def __init__(self, conn, room_id: int, message_id: Optional[int], parent_id: Optional[int]):
        self.conn = conn  # pymysql connection
        self.room_id = room_id
        self.message_id = message_id
        self.parent_id = parent_id
        self._runs: Dict[str, Dict[str, Any]] = {}  # run_id -> {"id": tool_call_id, "ts": perf_counter}

    def on_tool_start(self, serialized: Dict[str, Any], input_str: str, **kwargs: Any) -> None:
        tool_name = (serialized or {}).get("name") or "unknown_tool"
        run_id = str(kwargs.get("run_id") or str(time.time()))

        tool_type = _tool_type_from_name(tool_name)

        # request_json은 문자열로 들어오므로 JSON으로 감싸 저장
        request_obj = {"input": input_str}

        with self.conn.cursor() as cursor:
            cursor.execute(
                """
                INSERT INTO tool_call_log
                    (room_id, message_id, parent_id, tool_name, tool_type, request_json, status, started_at)
                VALUES
                    (%s, %s, %s, %s, %s, %s, 'success', NOW(6))
                """,
                (
                    self.room_id,
                    self.message_id,
                    self.parent_id,
                    tool_name,
                    tool_type,
                    json.dumps(request_obj, ensure_ascii=False),
                ),
            )
            tool_call_id = cursor.lastrowid
            self.conn.commit()

        self._runs[run_id] = {"id": tool_call_id, "ts": time.perf_counter()}

    def on_tool_end(self, output: Any, **kwargs: Any) -> None:
        run_id = kwargs.get("run_id")
        if run_id is None:
            return
        run_id = str(run_id)

        info = self._runs.get(run_id)
        if not info:
            return

        tool_call_id = info["id"]
        latency_ms = int((time.perf_counter() - info["ts"]) * 1000)

        # output이 dict/list면 그대로, 아니면 문자열로 감싸기
        if isinstance(output, (dict, list)):
            resp_obj = output
        else:
            resp_obj = {"output": str(output)}

        with self.conn.cursor() as cursor:
            cursor.execute(
                """
                UPDATE tool_call_log
                SET response_json=%s,
                    status='success',
                    finished_at=NOW(6),
                    latency_ms=%s
                WHERE tool_call_id=%s
                """,
                (
                    json.dumps(resp_obj, ensure_ascii=False),
                    latency_ms,
                    tool_call_id,
                ),
            )
            self.conn.commit()

    def on_tool_error(self, error: BaseException, **kwargs: Any) -> None:
        run_id = kwargs.get("run_id")
        if run_id is None:
            return
        run_id = str(run_id)

        info = self._runs.get(run_id)
        if not info:
            return

        tool_call_id = info["id"]
        latency_ms = int((time.perf_counter() - info["ts"]) * 1000)

        with self.conn.cursor() as cursor:
            cursor.execute(
                """
                UPDATE tool_call_log
                SET status='error',
                    error_code=%s,
                    error_message=%s,
                    finished_at=NOW(6),
                    latency_ms=%s
                WHERE tool_call_id=%s
                """,
                (
                    "TOOL_ERROR",
                    str(error),
                    latency_ms,
                    tool_call_id,
                ),
            )
            self.conn.commit()
