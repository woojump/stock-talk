from __future__ import annotations

import asyncio
from typing import Any, Dict, List

import pandas as pd
import FinanceDataReader as fdr
from sqlalchemy import text

from app.core.database import AsyncSessionLocal
from app.models.stock_info import StockInfo


TABLE = StockInfo.__tablename__


def to_chosung(s: str) -> str:
    CHO = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
    out = []
    for ch in (s or ""):
        code = ord(ch)
        if 0xAC00 <= code <= 0xD7A3:
            idx = (code - 0xAC00) // 588
            out.append(CHO[idx])
        else:
            out.append(ch)
    return "".join(out)


def normalize_fdr_df(df: pd.DataFrame) -> pd.DataFrame:
    code_col = "Code" if "Code" in df.columns else ("Symbol" if "Symbol" in df.columns else None)
    name_col = "Name" if "Name" in df.columns else ("Company" if "Company" in df.columns else None)

    market_col = "Market" if "Market" in df.columns else None
    dept_col = "Dept" if "Dept" in df.columns else ("Department" if "Department" in df.columns else None)
    marcap_col = "Marcap" if "Marcap" in df.columns else ("MarketCap" if "MarketCap" in df.columns else None)
    market_id_col = "MarketId" if "MarketId" in df.columns else ("MarketID" if "MarketID" in df.columns else None)

    if code_col is None or name_col is None:
        raise RuntimeError(f"FDR StockListing('KRX') 컬럼을 찾을 수 없습니다. columns={list(df.columns)}")

    out = pd.DataFrame()
    out["ticker"] = df[code_col].astype(str).str.strip()
    out["name"] = df[name_col].astype(str).str.strip()
    out["market"] = df[market_col].astype(str).str.strip() if market_col else None
    out["dept"] = df[dept_col].astype(str).str.strip() if dept_col else None
    out["market_id"] = df[market_id_col].astype(str).str.strip() if market_id_col else None

    if marcap_col:
        out["marcap"] = pd.to_numeric(df[marcap_col], errors="coerce").fillna(0).astype("int64")
    else:
        out["marcap"] = 0

    out["chosung"] = out["name"].apply(to_chosung)

    out = out[(out["ticker"] != "") & (out["name"] != "")]
    out = out.drop_duplicates(subset=["ticker"]).reset_index(drop=True)
    return out


async def upsert_stock_info(rows: List[Dict[str, Any]], batch_size: int = 1000) -> int:
    sql = text(f"""
        INSERT INTO {TABLE} (ticker, name, market, dept, marcap, market_id, chosung)
        VALUES (:ticker, :name, :market, :dept, :marcap, :market_id, :chosung)
        ON DUPLICATE KEY UPDATE
            name=VALUES(name),
            market=VALUES(market),
            dept=VALUES(dept),
            marcap=VALUES(marcap),
            market_id=VALUES(market_id),
            chosung=VALUES(chosung),
            updated_at=CURRENT_TIMESTAMP
    """)

    total = 0
    async with AsyncSessionLocal() as db:
        buf: List[Dict[str, Any]] = []
        for r in rows:
            buf.append(r)
            if len(buf) >= batch_size:
                await db.execute(sql, buf)
                await db.commit()
                total += len(buf)
                buf.clear()

        if buf:
            await db.execute(sql, buf)
            await db.commit()
            total += len(buf)

    return total


async def main():
    df_raw = fdr.StockListing("KRX")
    df_norm = normalize_fdr_df(df_raw)

    rows = df_norm.to_dict(orient="records")
    cnt = await upsert_stock_info(rows)

    print(f"OK: upserted={cnt}, df_rows={len(df_norm)} into table={TABLE}")


if __name__ == "__main__":
    asyncio.run(main())
