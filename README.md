# 2025-2 프메 8팀 프로젝트
# 📈 StockTalk
> **LLM + MCP기반 대화형 주식 앱**
---

<img src="https://github.com/user-attachments/assets/96ed5d66-e2b8-47b0-ac08-a8ad6753b383" width="400">

## 👥 프로젝트 소개
**개발 기간** 
2025.09 ~ 2026.02

**팀원**
권우주 (Lead & Frontend)
유동균 (Backend & AI)
이주혁 (Backend & AI)
한지민 (Backend & AI)
홍예나 (Design)

## 프로젝트 개요 (Overview)
기존의 복잡한 주식 시스템에서 벗어나, 사용자가 일상 언어로 질문하면 **실시간 주식 정보(시세 차트 등) 조회와 거래가 가능하도록**하는 지능형 에이전트입니다. MCP와 LLM를 활용하여 사용자에게 친숙한 새로운 접근 방식을 제시합니다.

## 프로젝트 기능
1. **MCP를 활용해 LLM모델에 프롬프트 엔지니어링을 적용해 주식이 어려운 초보자들에게 친숙한 AI비서**
* 자연어로 주식 관련 질문 및 응답 제공
* 자연어 대화로 주식 매도 매수 뉴스 등 모든 기능들을 LLM에게 명령어로 처리 가능

2. **시세, 차트, 뉴스(AI요약 포함) 등 금융 정보 제공**
* 키움 모의투자 api를 활용해 주식투자를 진행하고 포트폴리오로 보유한 종목 확인 가능
* 실시간 인기, 상승, 하락 등 화두에 오른 주식들 top5를 받아와 주식시장을 한눈에 확인 가능
* 주식관련 뉴스를 api로 받아오고 AI요약을 진행해 한눈에 뉴스 토픽 확인 가능
---

## 🛠 기술 스택 (Tech Stack)

### Languages & Frameworks
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"> <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white"> <img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"> <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white">

### Infrastructure & Databases
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white"> <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white">

### Tools
<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white">

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
