import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

Color getProfitColor(num value) {
  if (value > 0) {
    return AppColors.red; // Positive (profit/gain)
  } else if (value < 0) {
    return AppColors.blue400; // Negative (loss/decline)
  } else {
    return AppColors.gray500; // Neutral
  }
}

// Example: "+1,000원 (+5.0%)" or "-500원 (-2.5%)"
String formatProfitText(
  num profitLoss,
  num returnRate,
  NumberFormat format, {
  bool includeUnit = false,
}) {
  final profitSign = profitLoss > 0
      ? '+'
      : profitLoss < 0
      ? '-'
      : '';
  final rateSign = returnRate > 0
      ? '+'
      : returnRate < 0
      ? '-'
      : '';
  final profitValue = format.format(profitLoss.abs());
  final rateValue = returnRate.abs().toStringAsFixed(1);
  final unit = includeUnit ? '원' : '';
  return '$profitSign$profitValue$unit ($rateSign$rateValue%)';
}

// Example: "+1,000원 (5.0%)" or "-500원 (2.5%)"
String formatChangeText(
  num change,
  num changeRate,
  NumberFormat format, {
  bool includeUnit = true,
}) {
  return formatProfitText(change, changeRate, format, includeUnit: includeUnit);
}
