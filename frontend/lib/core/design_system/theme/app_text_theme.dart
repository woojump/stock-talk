import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/tokens/typography.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: AppTypography.titleXL,
        fontWeight: AppTypography.bold,
        fontFamily: AppTypography.fontFamily,
        height: 1.35,
      ),
      displayMedium: TextStyle(
        fontSize: AppTypography.titleL,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.64,
      ),
      displaySmall: TextStyle(
        fontSize: AppTypography.titleM,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.43,
      ),
      headlineLarge: TextStyle(
        fontSize: AppTypography.titleL,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.64,
      ),
      headlineMedium: TextStyle(
        fontSize: AppTypography.titleM,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.43,
      ),
      headlineSmall: TextStyle(
        fontSize: AppTypography.titleS,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.0,
      ),
      titleLarge: TextStyle(
        fontSize: AppTypography.titleXS,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.0,
      ),
      titleMedium: TextStyle(
        fontSize: AppTypography.labelXL,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: 1.6,
      ),
      titleSmall: TextStyle(
        fontSize: AppTypography.labelL,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: 1.27,
      ),
      bodyLarge: TextStyle(
        fontSize: AppTypography.bodyL,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: 1.51,
      ),
      bodyMedium: TextStyle(
        fontSize: AppTypography.bodyM,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: 1.7,
      ),
      bodySmall: TextStyle(
        fontSize: AppTypography.bodyS,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: 1.3,
      ),
      labelLarge: TextStyle(
        fontSize: AppTypography.labelXL,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: 1.6,
      ),
      labelMedium: TextStyle(
        fontSize: AppTypography.labelL,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: 1.27,
      ),
      labelSmall: TextStyle(
        fontSize: AppTypography.labelM,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: 1.27,
      ),
    );
  }
}
