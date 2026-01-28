import os
import FinanceDataReader as fdr
import pymysql
from dotenv import load_dotenv

# .env 파일 로드
load_dotenv()

def initialize_stock_db():
    try:
        # 1. KRX 종목 정보 가져오기
        print("🔍 FinanceDataReader로 종목 정보를 불러오는 중...")
        df_krx = fdr.StockListing('KRX')
        data_to_insert = df_krx[['Code', 'Name', 'Market', 'Dept', 'Marcap', 'MarketId']].values.tolist()

        # 2. DB 연결
        conn = pymysql.connect(
            host=os.getenv('DATABASE_HOST'),
            user=os.getenv('DATABASE_USERNAME'),
            password=os.getenv('DATABASE_PASSWORD'),
            db=os.getenv('DATABASE_NAME'),
            port=int(os.getenv('DATABASE_PORT', 3306)),
            charset='utf8mb4'
        )
        
        with conn.cursor() as cursor:
            # 3. 테이블 생성 (없을 때만)
            print("🏗️ stock_master 테이블 생성 중...")
            cursor.execute("""
            CREATE TABLE IF NOT EXISTS stock_master (
                ticker VARCHAR(20) PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                market VARCHAR(20),
                dept VARCHAR(50),
                marcap BIGINT,
                market_id VARCHAR(20),
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            );
            """)

            # 4. 데이터 삽입 (UPSERT)
            print(f"📦 데이터 저장 중... (총 {len(data_to_insert)}개)")
            sql = """
            INSERT INTO stock_master (ticker, name, market, dept, marcap, market_id)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                name = VALUES(name),
                market = VALUES(market),
                dept = VALUES(dept),
                marcap = VALUES(marcap),
                market_id = VALUES(market_id),
                updated_at = NOW()
            """
            cursor.executemany(sql, data_to_insert)
            
        conn.commit()
        print("✅ 모든 작업이 완료되었습니다! 이제 이 파일은 지우셔도 됩니다.")

    except Exception as e:
        print(f"❌ 에러 발생: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    initialize_stock_db()