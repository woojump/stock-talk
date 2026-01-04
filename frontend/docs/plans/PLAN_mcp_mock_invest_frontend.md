# Implementation Plan: MCP Mock Invest Flutter Frontend

**Status**: 🔄 In Progress
**Started**: 2026-01-03

---

**CRITICAL INSTRUCTIONS**: After completing each phase:
1. Check off completed task checkboxes
2. Run all quality gate validation commands
3. Verify ALL quality gate items pass
4. Only then proceed to next phase

---

## Overview

### Feature Description
LLM 채팅을 통해 주식을 매수/매도할 수 있는 Flutter 앱 프론트엔드 구현. 백엔드는 키움증권 REST API를 MCP 서버로 연동하며, LLM이 사용자 요청을 처리.

### Success Criteria
- [ ] 하단 네비게이션 바로 3개 페이지 이동 가능
- [ ] 채팅 페이지에서 LLM과 스트리밍 대화 가능
- [ ] 종목 검색 및 상세 정보 확인 가능
- [ ] 포트폴리오(잔고) 조회 가능
- [ ] 각 Phase 완료 시 앱이 실행 가능한 상태 유지

---

## Architecture Decisions

| Decision | Rationale |
|----------|-----------|
| Clean Architecture (간소화) | 레이어 분리로 테스트/유지보수 용이, 과도한 복잡성 배제 |
| Provider | 공식 권장, 학습 곡선 낮음, ChangeNotifier 기반 |
| get_it | 간단한 서비스 로케이터, Injectable 없이 수동 등록으로 단순화 |
| auto_route | 타입 안전 라우팅, 탭 네비게이션 지원 |
| Mock 데이터 우선 | 백엔드 독립적으로 UI 개발 가능 |

---

## Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router/
│       ├── app_router.dart
│       └── app_router.gr.dart (generated)
├── core/
│   ├── di/
│   │   └── injection.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── constants/
│       └── api_constants.dart
├── domain/
│   ├── entities/
│   │   ├── stock.dart
│   │   ├── portfolio_item.dart
│   │   └── chat_message.dart
│   └── repositories/
│       ├── i_stock_repository.dart
│       ├── i_portfolio_repository.dart
│       └── i_chat_repository.dart
├── data/
│   ├── models/
│   │   ├── stock_model.dart
│   │   ├── portfolio_item_model.dart
│   │   └── chat_message_model.dart
│   └── repositories/
│       ├── mock_stock_repository.dart
│       ├── mock_portfolio_repository.dart
│       └── mock_chat_repository.dart
├── presentation/
│   ├── providers/
│   │   ├── chat_provider.dart
│   │   ├── stock_search_provider.dart
│   │   └── portfolio_provider.dart
│   ├── pages/
│   │   ├── home/
│   │   │   └── home_page.dart
│   │   ├── chat/
│   │   │   └── chat_page.dart
│   │   ├── stock_search/
│   │   │   ├── stock_search_page.dart
│   │   │   └── stock_detail_page.dart
│   │   └── portfolio/
│   │       └── portfolio_page.dart
│   └── widgets/
│       ├── common/
│       ├── chat/
│       ├── stock/
│       └── portfolio/
```

---

## Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  get_it: ^8.0.3
  auto_route: ^9.2.2
  dio: ^5.7.0
  equatable: ^2.0.7
  intl: ^0.20.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.14
  auto_route_generator: ^9.0.0
```

---

## Phase 1: Foundation & Navigation Shell

**Goal**: 프로젝트 기반 설정 및 탭 네비게이션 동작

### Tasks

- [ ] **1.1** pubspec.yaml에 dependencies 추가
- [ ] **1.2** `lib/core/di/injection.dart` - GetIt 설정
- [ ] **1.3** `lib/core/theme/app_theme.dart` - 기본 테마
- [ ] **1.4** `lib/app/router/app_router.dart` - AutoRoute 설정
- [ ] **1.5** `lib/presentation/pages/home/home_page.dart` - BottomNavigationBar 쉘
- [ ] **1.6** `lib/presentation/pages/chat/chat_page.dart` - Placeholder
- [ ] **1.7** `lib/presentation/pages/stock_search/stock_search_page.dart` - Placeholder
- [ ] **1.8** `lib/presentation/pages/portfolio/portfolio_page.dart` - Placeholder
- [ ] **1.9** `lib/app/app.dart` - MaterialApp with Router
- [ ] **1.10** `lib/main.dart` - Entry point 업데이트
- [ ] **1.11** `dart run build_runner build` 실행

### Quality Gate
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run  # 앱 실행하여 탭 네비게이션 확인
```

- [ ] 앱 빌드 성공
- [ ] 3개 탭 네비게이션 동작
- [ ] 각 탭 전환 시 해당 placeholder 페이지 표시

---

## Phase 2: Data Layer & Mock Repositories

**Goal**: 도메인 엔티티 및 Mock 데이터 레이어 구축

### Tasks

- [ ] **2.1** `lib/domain/entities/stock.dart` - Stock 엔티티
- [ ] **2.2** `lib/domain/entities/portfolio_item.dart` - PortfolioItem 엔티티
- [ ] **2.3** `lib/domain/entities/chat_message.dart` - ChatMessage 엔티티
- [ ] **2.4** `lib/domain/repositories/i_stock_repository.dart` - 인터페이스
- [ ] **2.5** `lib/domain/repositories/i_portfolio_repository.dart` - 인터페이스
- [ ] **2.6** `lib/domain/repositories/i_chat_repository.dart` - 인터페이스
- [ ] **2.7** `lib/data/repositories/mock_stock_repository.dart` - 한국 주식 Mock 데이터
- [ ] **2.8** `lib/data/repositories/mock_portfolio_repository.dart` - Mock 보유 종목
- [ ] **2.9** `lib/data/repositories/mock_chat_repository.dart` - Mock LLM 응답 (스트리밍)
- [ ] **2.10** `lib/core/di/injection.dart` 업데이트 - Repository 등록

### Quality Gate
```bash
flutter analyze
flutter test  # 엔티티 테스트
```

- [ ] 모든 엔티티 정의 완료
- [ ] Mock Repository가 샘플 데이터 반환
- [ ] DI 컨테이너에 등록 완료

---

## Phase 3: Portfolio Page (잔고 페이지)

**Goal**: 보유 종목 목록 및 수익률 표시

### Tasks

- [ ] **3.1** `lib/presentation/providers/portfolio_provider.dart` - 상태 관리
- [ ] **3.2** `lib/presentation/widgets/portfolio/portfolio_summary_card.dart` - 총 자산/수익률
- [ ] **3.3** `lib/presentation/widgets/portfolio/portfolio_item_card.dart` - 개별 종목 카드
- [ ] **3.4** `lib/presentation/widgets/common/loading_indicator.dart` - 로딩 위젯
- [ ] **3.5** `lib/presentation/widgets/common/error_widget.dart` - 에러 위젯
- [ ] **3.6** `lib/presentation/pages/portfolio/portfolio_page.dart` - 전체 구현
- [ ] **3.7** Provider 등록 (main.dart 또는 app.dart)

### Quality Gate
```bash
flutter analyze
flutter run  # Portfolio 탭에서 Mock 데이터 확인
```

- [ ] 총 자산, 총 수익률 표시
- [ ] 보유 종목 리스트 표시 (종목명, 수량, 매입가, 현재가, 수익률)
- [ ] 수익률 색상 표시 (빨강/초록)
- [ ] Pull-to-refresh 동작

---

## Phase 4: Stock Search Page (종목 검색 페이지)

**Goal**: 종목 검색 및 상세 정보 표시

### Tasks

- [ ] **4.1** `lib/presentation/providers/stock_search_provider.dart` - 검색 상태 관리
- [ ] **4.2** `lib/presentation/widgets/stock/stock_search_bar.dart` - 검색 입력
- [ ] **4.3** `lib/presentation/widgets/stock/stock_list_tile.dart` - 검색 결과 아이템
- [ ] **4.4** `lib/presentation/widgets/stock/stock_price_display.dart` - 가격/등락률 표시
- [ ] **4.5** `lib/presentation/pages/stock_search/stock_search_page.dart` - 전체 구현
- [ ] **4.6** `lib/presentation/pages/stock_search/stock_detail_page.dart` - 상세 페이지
- [ ] **4.7** `lib/app/router/app_router.dart` 업데이트 - 상세 페이지 라우트 추가
- [ ] **4.8** Provider 등록

### Quality Gate
```bash
flutter analyze
dart run build_runner build --delete-conflicting-outputs
flutter run  # 검색 기능 및 상세 페이지 확인
```

- [ ] 종목명/티커 검색 동작
- [ ] 검색 결과 리스트 표시
- [ ] 종목 탭 시 상세 페이지 이동
- [ ] 상세 페이지에서 종목 정보 표시

---

## Phase 5: Chat Page (채팅 페이지)

**Goal**: LLM 채팅 인터페이스 (스트리밍 응답)

### Tasks

- [x] **5.1** `lib/presentation/providers/chat_provider.dart` - 채팅 상태 관리 (스트리밍 지원)
- [x] **5.2** `lib/presentation/widgets/chat/chat_bubble.dart` - 메시지 버블 기본
- [x] **5.3** `lib/presentation/widgets/chat/user_bubble.dart` - 사용자 메시지
- [x] **5.4** `lib/presentation/widgets/chat/assistant_bubble.dart` - LLM 메시지 (스트리밍)
- [x] **5.5** `lib/presentation/widgets/chat/chat_input_field.dart` - 메시지 입력 필드
- [x] **5.6** `lib/presentation/widgets/chat/typing_indicator.dart` - 타이핑 인디케이터
- [x] **5.7** `lib/presentation/pages/chat/chat_page.dart` - 전체 구현
- [x] **5.8** Provider 등록

### Quality Gate
```bash
flutter analyze
flutter run  # 채팅 기능 확인
```

- [ ] 메시지 전송 동작
- [ ] 스트리밍 응답 표시 (글자 단위로 표시)
- [ ] 메시지 목록 스크롤 동작
- [ ] 입력 필드 키보드 처리

---

## Phase 6: API Integration (선택적 - 백엔드 준비 후)

**Goal**: 실제 백엔드 API 연동

### Tasks

- [ ] **6.1** `lib/core/constants/api_constants.dart` - API 엔드포인트
- [ ] **6.2** `lib/data/services/api_service.dart` - Dio 클라이언트
- [ ] **6.3** `lib/data/models/stock_model.dart` - JSON 파싱
- [ ] **6.4** `lib/data/models/portfolio_item_model.dart` - JSON 파싱
- [ ] **6.5** `lib/data/models/chat_message_model.dart` - JSON 파싱
- [ ] **6.6** `lib/data/repositories/stock_repository_impl.dart` - 실제 구현
- [ ] **6.7** `lib/data/repositories/portfolio_repository_impl.dart` - 실제 구현
- [ ] **6.8** `lib/data/repositories/chat_repository_impl.dart` - 실제 구현 (SSE/WebSocket)
- [ ] **6.9** `lib/core/di/injection.dart` 업데이트 - 실제 Repository로 교체

### Quality Gate
```bash
flutter analyze
flutter run  # 실제 API 데이터 확인
```

- [ ] 실제 종목 데이터 조회
- [ ] 실제 포트폴리오 데이터 조회
- [ ] 실제 LLM 응답 스트리밍

---

## Key Files Summary

| Phase | Critical Files |
|-------|---------------|
| 1 | `pubspec.yaml`, `main.dart`, `app_router.dart`, `home_page.dart` |
| 2 | `domain/entities/*.dart`, `domain/repositories/*.dart`, `data/repositories/mock_*.dart` |
| 3 | `portfolio_provider.dart`, `portfolio_page.dart`, `portfolio_item_card.dart` |
| 4 | `stock_search_provider.dart`, `stock_search_page.dart`, `stock_detail_page.dart` |
| 5 | `chat_provider.dart`, `chat_page.dart`, `assistant_bubble.dart` |
| 6 | `api_service.dart`, `data/repositories/*_impl.dart` |

---

## Validation Commands

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (auto_route)
dart run build_runner build --delete-conflicting-outputs

# 정적 분석
flutter analyze

# 테스트 실행
flutter test

# 앱 실행
flutter run
```

---

## Notes

- 각 Phase 완료 시 반드시 `flutter run`으로 앱 실행 확인
- Mock Repository는 한국 주식 데이터 사용 (삼성전자, SK하이닉스 등)
- 스트리밍 채팅은 Stream<String>으로 구현하여 글자 단위 표시
- Phase 6은 백엔드 준비 후 진행
