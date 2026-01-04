import '../../domain/entities/portfolio_item.dart';
import '../../domain/repositories/i_portfolio_repository.dart';

class MockPortfolioRepository implements IPortfolioRepository {
  final List<PortfolioItem> _mockPortfolio = const [
    PortfolioItem(
      stockCode: '005930',
      stockName: '삼성전자',
      quantity: 100,
      averagePrice: 68000,
      currentPrice: 71500,
      totalPurchaseAmount: 6800000,
      totalCurrentValue: 7150000,
      profitLoss: 350000,
      profitLossPercent: 5.15,
    ),
    PortfolioItem(
      stockCode: '000660',
      stockName: 'SK하이닉스',
      quantity: 30,
      averagePrice: 185000,
      currentPrice: 178000,
      totalPurchaseAmount: 5550000,
      totalCurrentValue: 5340000,
      profitLoss: -210000,
      profitLossPercent: -3.78,
    ),
    PortfolioItem(
      stockCode: '035420',
      stockName: 'NAVER',
      quantity: 20,
      averagePrice: 200000,
      currentPrice: 215000,
      totalPurchaseAmount: 4000000,
      totalCurrentValue: 4300000,
      profitLoss: 300000,
      profitLossPercent: 7.50,
    ),
    PortfolioItem(
      stockCode: '035720',
      stockName: '카카오',
      quantity: 50,
      averagePrice: 52000,
      currentPrice: 48500,
      totalPurchaseAmount: 2600000,
      totalCurrentValue: 2425000,
      profitLoss: -175000,
      profitLossPercent: -6.73,
    ),
    PortfolioItem(
      stockCode: '066570',
      stockName: 'LG전자',
      quantity: 40,
      averagePrice: 95000,
      currentPrice: 98500,
      totalPurchaseAmount: 3800000,
      totalCurrentValue: 3940000,
      profitLoss: 140000,
      profitLossPercent: 3.68,
    ),
  ];

  @override
  Future<List<PortfolioItem>> getPortfolio() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockPortfolio;
  }

  @override
  Future<int> getTotalAssets() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockPortfolio.fold<int>(
      0,
      (sum, item) => sum + item.totalCurrentValue,
    );
  }

  @override
  Future<int> getTotalProfitLoss() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockPortfolio.fold<int>(
      0,
      (sum, item) => sum + item.profitLoss,
    );
  }

  @override
  Future<double> getTotalProfitLossPercent() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final totalPurchase = _mockPortfolio.fold<int>(
      0,
      (sum, item) => sum + item.totalPurchaseAmount,
    );
    final totalCurrent = _mockPortfolio.fold<int>(
      0,
      (sum, item) => sum + item.totalCurrentValue,
    );
    if (totalPurchase == 0) return 0.0;
    return ((totalCurrent - totalPurchase) / totalPurchase) * 100;
  }
}
