from dotenv import load_dotenv
load_dotenv()

from fastapi import FastAPI
from app.api.api_v1.api import api_router
from app.api.api_v1.endpoints import news
import uvicorn



app = FastAPI(
    title="LLM-MCP 주식 투자 플랫폼",
    description="DB 없이 키움 REST API를 직접 연동하는 에이전트 서비스",
    version="1.1.0"
)

app.include_router(api_router, prefix="/api/v1")
app.include_router(news.router, prefix="/api/v1/news", tags=["news"])


@app.get("/")
def root():
    return {"status": "running", "mode": "No-DB Direct API"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)