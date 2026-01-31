import 'package:flutter/material.dart';

/// 앱 전역에서 사용하는 타이포그래피 토큰
/// Figma Variables에서 추출한 값을 Mobile에 맞게 조정
class AppTypography {
  AppTypography._();

  // Font family
  static const String fontFamily = 'Pretendard';

  // Font sizes (Mobile 기준으로 Desktop 값을 스케일 다운)
  static const double displayLarge = 32.0; // Desktop: 48px → Mobile: 32px
  static const double headlineLarge = 24.0; // Desktop: Title/XL
  static const double headlineMedium = 20.0; // Desktop: Title/S
  static const double titleLarge = 18.0;
  static const double titleMedium = 16.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0; // Desktop: Body/M (Default)
  static const double bodySmall = 12.0; // Desktop: Body/Semibold/S
  static const double labelSmall = 10.0;

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Line heights (Mobile 기준 조정)
  static const double lineHeightDisplayLarge = 40.0; // Desktop: 62 → Mobile: 40
  static const double lineHeightHeadline = 32.0; // Desktop: 32 유지
  static const double lineHeightBody = 22.0; // Desktop: 22 유지
  static const double lineHeightBodySmall = 18.0; // Desktop: 18 유지

  // Letter spacing
  static const double letterSpacing = 0.0;
}
