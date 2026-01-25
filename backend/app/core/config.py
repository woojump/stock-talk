from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    PROJECT_NAME: str = "LLM-MCP Stock Platform"
    OPENAI_API_KEY: str  # 서버에서 사용할 AI 키
    MODEL_NAME: str = "gpt-4o-mini"

    KIWOOM_APP_KEY: str
    KIWOOM_APP_SECRET: str
       
    KIWOOM_ACCOUNT_NO: str

    # 네이버 API 키 추가
    NAVER_CLIENT_ID: str
    NAVER_CLIENT_SECRET: str

    DATABASE_HOST: str
    DATABASE_USERNAME: str
    DATABASE_PASSWORD: str
    DATABASE_PORT: str
    DATABASE_NAME: str

    # Pydantic 설정 (DB 에러 방지용)
    model_config = SettingsConfigDict(
        env_file=".env",
        extra="ignore"  # 정의되지 않은 DB 변수들이 들어와도 에러를 내지 않음
    )

settings = Settings()
