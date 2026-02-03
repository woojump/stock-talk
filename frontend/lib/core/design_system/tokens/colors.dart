import 'package:flutter/material.dart';

/// 앱 전역에서 사용하는 색상 토큰
/// Figma Variables에서 추출한 값을 기반으로 정의
class AppColors {
  AppColors._();

  // Common
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF222222);
  static const transparent = Color(0x00000000);

  // Gray scale - Light
  static const gray800 = Color(0xFF222222);
  static const gray700 = Color(0xFF4A4E52);
  static const gray600 = Color(0xFF636970);
  static const gray500 = Color(0xFF8B919B);
  static const gray400 = Color(0xFFB5B9C2);
  static const gray300 = Color(0xFFE2E5E8);
  static const gray200 = Color(0xFFF3F3F3);
  static const gray100 = Color(0xFFFCFCFC);

  // Blue
  static const blue500 = Color(0xFF0059CD);
  static const blue400 = Color(0xFF0077EA);
  static const blue300 = Color(0xFF4BAEFE); // Primary color
  static const blue200 = Color(0xFFCBE8FE);
  static const blue100 = Color(0xFFEAEDF3);

  // Sub colors
  static const red = Color(0xFFFF604C);
}
