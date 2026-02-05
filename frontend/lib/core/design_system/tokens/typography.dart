import 'package:flutter/material.dart';

/// 앱 전역에서 사용하는 타이포그래피 토큰
class AppTypography {
  AppTypography._();

  // Font family
  static const String fontFamily = 'Pretendard';

  // Font sizes
  static const double titleXL = 24.0;
  static const double titleL = 22.0;
  static const double titleM = 19.0;
  static const double titleS = 17.0;
  static const double titleXS = 16.0;

  static const double bodyL = 19.0;
  static const double bodyM = 18.0;
  static const double bodyS = 16.0;
  static const double bodyXS = 16.0;

  static const double labelXL = 15.0;
  static const double labelL = 13.0;
  static const double labelM = 10.0;

  static const double buttonTextL = 18.0;
  static const double buttonTextM = 16.0;

  // Font weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
