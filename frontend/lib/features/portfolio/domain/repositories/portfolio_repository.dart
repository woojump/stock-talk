import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';

abstract class PortfolioRepository {
  Future<PortfolioBalance> fetchBalance();
}
