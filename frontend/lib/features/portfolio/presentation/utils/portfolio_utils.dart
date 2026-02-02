import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/utils/stock_utils.dart' as stock_utils;
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
  return stock_utils.formatProfitText(
    profitLoss,
    returnRate,
    format,
    includeUnit: includeUnit,
  );
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
  return stock_utils.getProfitColor(profitAmount);
}

int calculatePendingOrderAmount(PortfolioBalance balance) {
  return balance.summary.totalAsset - balance.summary.availableCash;
}
