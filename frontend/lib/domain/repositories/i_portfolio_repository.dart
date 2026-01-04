import '../entities/portfolio_item.dart';

abstract class IPortfolioRepository {
  Future<List<PortfolioItem>> getPortfolio();
  Future<int> getTotalAssets();
  Future<int> getTotalProfitLoss();
  Future<double> getTotalProfitLossPercent();
}
