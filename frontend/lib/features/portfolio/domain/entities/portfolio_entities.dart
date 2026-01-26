class PortfolioBalance {
  const PortfolioBalance({required this.summary, required this.holdings});

  final PortfolioSummary summary;
  final List<PortfolioHolding> holdings;
}

class PortfolioSummary {
  const PortfolioSummary({
    required this.totalAsset,
    required this.availableCash,
    required this.totalProfitLoss,
    required this.totalReturnRate,
  });

  final int totalAsset;
  final int availableCash;
  final int totalProfitLoss;
  final double totalReturnRate;
}

class PortfolioHolding {
  const PortfolioHolding({
    required this.ticker,
    required this.name,
    required this.quantity,
    required this.purchasePrice,
    required this.currentPrice,
    required this.profitLossRate,
  });

  final String ticker;
  final String name;
  final int quantity;
  final int purchasePrice;
  final int currentPrice;
  final double profitLossRate;
}
