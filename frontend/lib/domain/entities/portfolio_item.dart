import 'package:equatable/equatable.dart';

class PortfolioItem extends Equatable {
  final String stockCode;
  final String stockName;
  final int quantity;
  final int averagePrice;
  final int currentPrice;
  final int totalPurchaseAmount;
  final int totalCurrentValue;
  final int profitLoss;
  final double profitLossPercent;

  const PortfolioItem({
    required this.stockCode,
    required this.stockName,
    required this.quantity,
    required this.averagePrice,
    required this.currentPrice,
    required this.totalPurchaseAmount,
    required this.totalCurrentValue,
    required this.profitLoss,
    required this.profitLossPercent,
  });

  bool get isProfit => profitLoss > 0;
  bool get isLoss => profitLoss < 0;

  @override
  List<Object?> get props => [
        stockCode,
        stockName,
        quantity,
        averagePrice,
        currentPrice,
        totalPurchaseAmount,
        totalCurrentValue,
        profitLoss,
        profitLossPercent,
      ];
}
