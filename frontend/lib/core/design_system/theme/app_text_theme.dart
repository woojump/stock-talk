import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/tokens/typography.dart';

/// Material TextTheme을 Figma 타이포그래피에 매핑
class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme {
    return TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: AppTypography.displayLarge,
        fontWeight: AppTypography.bold,
        fontFamily: AppTypography.fontFamily,
        height:
            AppTypography.lineHeightDisplayLarge / AppTypography.displayLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),
      displayMedium: TextStyle(
        fontSize: AppTypography.headlineLarge,
        fontWeight: AppTypography.bold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightHeadline / AppTypography.headlineLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),
      displaySmall: TextStyle(
        fontSize: AppTypography.headlineMedium,
        fontWeight: AppTypography.bold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightHeadline / AppTypography.headlineMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: AppTypography.headlineLarge,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightHeadline / AppTypography.headlineLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),
      headlineMedium: TextStyle(
        fontSize: AppTypography.headlineMedium,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightHeadline / AppTypography.headlineMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),
      headlineSmall: TextStyle(
        fontSize: AppTypography.titleLarge,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightHeadline / AppTypography.titleLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: AppTypography.titleLarge,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.titleLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),
      titleMedium: TextStyle(
        fontSize: AppTypography.titleMedium,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.titleMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),
      titleSmall: TextStyle(
        fontSize: AppTypography.bodyMedium,
        fontWeight: AppTypography.semiBold,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.bodyMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: AppTypography.bodyLarge,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.bodyLarge,
        letterSpacing: AppTypography.letterSpacing,
      ),
      bodyMedium: TextStyle(
        fontSize: AppTypography.bodyMedium,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.bodyMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),
      bodySmall: TextStyle(
        fontSize: AppTypography.bodySmall,
        fontWeight: AppTypography.regular,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBodySmall / AppTypography.bodySmall,
        letterSpacing: AppTypography.letterSpacing,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: AppTypography.bodyMedium,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBody / AppTypography.bodyMedium,
        letterSpacing: AppTypography.letterSpacing,
      ),
      labelMedium: TextStyle(
        fontSize: AppTypography.bodySmall,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBodySmall / AppTypography.bodySmall,
        letterSpacing: AppTypography.letterSpacing,
      ),
      labelSmall: TextStyle(
        fontSize: AppTypography.labelSmall,
        fontWeight: AppTypography.medium,
        fontFamily: AppTypography.fontFamily,
        height: AppTypography.lineHeightBodySmall / AppTypography.labelSmall,
        letterSpacing: AppTypography.letterSpacing,
      ),
    );
  }
}
