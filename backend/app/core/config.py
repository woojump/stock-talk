from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    PROJECT_NAME: str = "LLM-MCP Stock Platform"
    OPENAI_API_KEY: str  # 서버에서 사용할 AI 키
    MODEL_NAME: str = "gpt-4o-mini"

    KIWOOM_APP_KEY: str
    KIWOOM_APP_SECRET: str
    # KIWOOM_ACCOUNT_NO: str
    DATA_PORTAL_KEY: str

    class Config:
        env_file = ".env"


settings = Settings()
