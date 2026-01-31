import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/tokens/colors.dart';

/// Material ColorScheme을 Figma 색상에 매핑
class AppColorScheme {
  AppColorScheme._();

  static ColorScheme light() {
    return ColorScheme.light(
      primary: AppColors.blue400,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.blue100,
      onPrimaryContainer: AppColors.blue400,
      secondary: AppColors.gray600,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.gray200,
      onSecondaryContainer: AppColors.gray800,
      tertiary: AppColors.blue300,
      onTertiary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
      surfaceContainerHighest: AppColors.gray100,
      onSurfaceVariant: AppColors.gray600,
      outline: AppColors.borderDefault,
      outlineVariant: AppColors.gray300,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.gray800,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.blue300,
    );
  }

  static ColorScheme dark() {
    return ColorScheme.dark(
      primary: AppColors.blue400,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.blue500,
      onPrimaryContainer: AppColors.blue100,
      secondary: AppColors.gray400,
      onSecondary: AppColors.gray800,
      secondaryContainer: AppColors.gray700,
      onSecondaryContainer: AppColors.gray200,
      tertiary: AppColors.blue200,
      onTertiary: AppColors.gray800,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.gray800,
      onSurface: AppColors.white,
      surfaceContainerHighest: AppColors.gray700,
      onSurfaceVariant: AppColors.gray400,
      outline: AppColors.gray600,
      outlineVariant: AppColors.gray700,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.gray200,
      onInverseSurface: AppColors.gray800,
      inversePrimary: AppColors.blue400,
    );
  }
}
