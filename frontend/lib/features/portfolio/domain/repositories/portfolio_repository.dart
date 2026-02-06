import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';

abstract class PortfolioRepository {
  Future<PortfolioBalance> fetchBalance();
  Future<OrderHistory> fetchOrderHistory({String qryTp = "1"});
}
