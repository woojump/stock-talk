from __future__ import annotations

from typing import Any, Dict, List, Optional


FIELD_MAP = {
    "9001": "ticker",
    "302": "name",
    "10": "price",
    "25": "sign",
    "11": "change",
    "12": "change_rate",
    "13": "volume",
    "16": "open",
    "17": "high",
    "18": "low",
}


def _to_int(s: Any) -> Optional[int]:
    if s is None:
        return None
    if isinstance(s, int):
        return s
    t = str(s).strip()
    if t == "":
        return None
    try:
        return int(t)
    except ValueError:
        return None

def change_rate_percent(s: Any) -> Optional[float]:
    i = _to_int(s)
    if i is None:
        return None
    return i / 100.0


def normalize_condition_rows(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    out: List[Dict[str, Any]] = []

    for r in rows:
        mapped: Dict[str, Any] = {}
        for k, v in r.items():
            key = FIELD_MAP.get(str(k), str(k))
            mapped[key] = v

        raw_ticker = str(mapped.get("ticker", "")).strip()
        ticker = raw_ticker[1:] if raw_ticker.startswith("A") else raw_ticker  # A005930 -> 005930

        item = {
            "ticker": ticker,
            "name": str(mapped.get("name", "")).strip(),
            "price": _to_int(mapped.get("price")),
            "change_rate": change_rate_percent(mapped.get("change_rate")),
            "change": _to_int(mapped.get("change")),
            "volume": _to_int(mapped.get("volume")),
            "open": _to_int(mapped.get("open")),
            "high": _to_int(mapped.get("high")),
            "low": _to_int(mapped.get("low")),
            "sign": str(mapped.get("sign", "")).strip(),
        }
        
        if item["ticker"] and item["name"]:
            out.append(item)

    return out
