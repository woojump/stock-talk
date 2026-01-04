import '../entities/stock.dart';

abstract class IStockRepository {
  Future<List<Stock>> searchStocks(String query);
  Future<Stock> getStockDetail(String code);
  Future<List<Stock>> getPopularStocks();
}
