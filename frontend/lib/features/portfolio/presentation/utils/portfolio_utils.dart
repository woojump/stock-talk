import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';

int evaluationAmount(PortfolioHolding holding) {
  return holding.currentPrice * holding.quantity;
}

int purchaseTotal(PortfolioHolding holding) {
  return holding.purchasePrice * holding.quantity;
}

int profitAmount(PortfolioHolding holding) {
  return evaluationAmount(holding) - purchaseTotal(holding);
}

int totalEvaluationAmount(PortfolioBalance balance) {
  return balance.holdings.fold<int>(
    0,
    (sum, holding) => sum + evaluationAmount(holding),
  );
}

int totalHoldingsCost(PortfolioBalance balance) {
  return balance.holdings.fold<int>(
    0,
    (sum, holding) => sum + purchaseTotal(holding),
  );
}

int totalProfitLoss(PortfolioBalance balance) {
  return totalEvaluationAmount(balance) - totalHoldingsCost(balance);
}

double totalReturnRate(PortfolioBalance balance) {
  final base = balance.summary.availableCash + totalHoldingsCost(balance);
  if (base == 0) {
    return 0;
  }
  return totalProfitLoss(balance) / base * 100;
}

String formatProfitText(
  int profitLoss,
  double returnRate,
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

double calculateStockReturnRate(PortfolioBalance balance) {
  final totalCost = totalHoldingsCost(balance);
  if (totalCost == 0) {
    return 0;
  }
  final profit = totalProfitLoss(balance);
  return (profit / totalCost) * 100;
}

Color getProfitColor(int profitAmount) {
  if (profitAmount > 0) {
    return AppColors.red;
  } else if (profitAmount < 0) {
    return AppColors.blue400;
  } else {
    return AppColors.gray600;
  }
}

int calculatePendingOrderAmount(PortfolioBalance balance) {
  return balance.summary.totalAsset - balance.summary.availableCash;
}
