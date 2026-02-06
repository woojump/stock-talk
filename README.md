# 2025-2 프메 8팀 프로젝트
# 📈 StockTalk
> **LLM + MCP기반 대화형 주식 앱**
---
![Image](https://github.com/user-attachments/assets/96ed5d66-e2b8-47b0-ac08-a8ad6753b383)

## 👥 프로젝트 정보
* **개발 기간**: 2026.01 ~ 2026.02 (진행 중)
* **팀 구성**: 1인 개발 프로젝트
* **관련 프로젝트**: [이전 키움 API 기반 트레이딩 시스템](링크)의 연장선상

## 📝 프로젝트 개요 (Overview)
기존의 복잡한 주식 HTS/MTS 시스템에서 벗어나, 사용자가 일상 언어로 질문하면 **실시간 시장 데이터와 뉴스를 종합하여 즉각적인 분석과 시각화 차트를 제공**하는 지능형 에이전트입니다. MCP(Model Context Protocol)를 활용하여 도구(Tool) 확장성을 극대화했습니다.

## 🎯 프로젝트 목표 (Goals)
1. **정밀한 종목 분석**: LLM의 Hallucination을 최소화하고 실시간 데이터 기반의 신뢰도 높은 분석 제공
2. **동적 시각화**: 텍스트 답변에 그치지 않고 JSON 구조를 활용한 인터랙티브 차트 렌더링
3. **사용자 경험(UX) 혁신**: "나 삼성전자 10주 있는데 어때?"와 같은 개인화된 질문 이해 및 대응
4. **확장성 확보**: FastMCP 프레임워크를 통한 새로운 금융 데이터 API의 손쉬운 통합

---

## 🛠 기술 스택 (Tech Stack)

### 🧠 AI & Backend
| Category | Tech Stack |
| :--- | :--- |
| **Language** | ![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=flat-square&logo=python&logoColor=white) |
| **LLM Framework** | ![LangChain](https://img.shields.io/badge/LangChain-123456?style=flat-square&logo=langchain&logoColor=white) |
| **Models** | ![GPT-4o](https://img.shields.io/badge/GPT--4o-41ADFF?style=flat-square&logo=openai) ![Gemini](https://img.shields.io/badge/Google_Gemini-8E75B2?style=flat-square&logo=googlegemini&logoColor=white) |
| **Server** | ![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=flat-square&logo=fastapi) ![MCP](https://img.shields.io/badge/FastMCP-orange?style=flat-square) |
| **Package Manager** | ![uv](https://img.shields.io/badge/uv-F43F5E?style=flat-square&logo=python) |

### 🗄️ Database & Tools
* **Vector DB**: Milvus / ChromaDB (RAG 기반 뉴스 검색용)
* **API 연동**: 키움 Open API (Koapy), Google Finance, News API
* **Deployment**: Docker, AWS EC2, Ubuntu via WSL

---

## 📂 프로젝트 주요 구조
```text
backend/
├── app/
│   ├── api/          # 메인 채팅 인터페이스 및 에이전트 로직
│   ├── core/         # 시스템 프롬프트 및 환경 설정 (Security)
│   ├── mcp/          # 실시간 데이터 조회를 위한 MCP 도구 서버
│   └── services/     # 외부 API 연동 서비스 레이어
└── .env              # 환경 변수 관리
