# stock_talk

## TODO

- [x] iOS 배포는 추후 고려 예정
- [ ] 안드로이드 앱 아이콘 크기 커보이는 문제 해결
- [ ] 포트폴리오 상세 페이지에서도 하단 내비게이션 보이게
- [x] 디자인 입히기
- [ ] 스플래시 다크모드 추가

## 프로덕션 빌드

### Android

`flutter build appbundle --release --dart-define=PROD=true`

### iOS

`flutter build ipa --dart-define=PROD=true`
