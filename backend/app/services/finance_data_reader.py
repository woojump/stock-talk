from __future__ import annotations

import os
from typing import Any, Dict, List
from sqlalchemy import create_engine, text
from sqlalchemy.engine import Engine


class FinanceDataService:
    MAX_SEARCH_RESULTS = 10

    def __init__(self):
        self._engine: Engine = create_engine(
            self._build_mysql_url(),
            pool_pre_ping=True,
        )

    def _build_mysql_url(self) -> str:
        """
        .env에 정의된 DB 정보를 이용해 MySQL SQLAlchemy URL 생성
        """
        host = os.getenv("DATABASE_HOST")
        user = os.getenv("DATABASE_USERNAME")
        password = os.getenv("DATABASE_PASSWORD")
        port = os.getenv("DATABASE_PORT", "3306")
        db = os.getenv("DATABASE_NAME")

        if not all([host, user, password, db]):
            raise RuntimeError("DATABASE 환경 변수가 올바르게 설정되지 않았습니다.")

        return (
            f"mysql+pymysql://{user}:{password}"
            f"@{host}:{port}/{db}?charset=utf8mb4"
        )

    def search(self, q: str) -> List[Dict[str, Any]]:
        q = (q or "").strip()
        if not q:
            return []

        sql = text("""
            SELECT
                ticker,
                name,
                market,
                dept,
                marcap,
                market_id
            FROM stock_info
            WHERE name LIKE :name_like
               OR ticker LIKE :ticker_like
            ORDER BY
                CASE WHEN name LIKE :prefix_like THEN 0 ELSE 1 END,
                marcap DESC
            LIMIT :limit
        """)

        params = {
            "name_like": f"%{q}%",
            "ticker_like": f"%{q}%",
            "prefix_like": f"{q}%",
            "limit": self.MAX_SEARCH_RESULTS,
        }

        with self._engine.connect() as conn:
            rows = conn.execute(sql, params).mappings().all()

        # ✅ 기존 인터페이스 유지
        return [{"srtnCd": r["ticker"], "itmsNm": r["name"]} for r in rows]


# ✅ 인스턴스 생성 (라우터에서 그대로 사용)
finance_data_service = FinanceDataService()
