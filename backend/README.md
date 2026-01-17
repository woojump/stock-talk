# 백엔드 디렉토리

# uv 환경 설정

## uv 설치

`pip install uv`

## uv 가상환경에 의존성 설치

`uv add -r requirements.txt`

## uv에서 실행

기존 `python`을 `uv run`으로 대체하기

예시:
`python uvicorn app.main:app --reload` => `uv run uvicorn app.main:app --reload`
