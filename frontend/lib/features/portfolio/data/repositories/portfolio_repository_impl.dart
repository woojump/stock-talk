import 'package:stock_talk/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._remoteDataSource);

  final PortfolioRemoteDataSource _remoteDataSource;

  @override
  Future<PortfolioBalance> fetchBalance() async {
    final dto = await _remoteDataSource.fetchBalance();
    return dto.toEntity();
  }

  @override
  Future<OrderHistory> fetchOrderHistory({String qryTp = "1"}) async {
    final dto = await _remoteDataSource.fetchOrderHistory(qryTp: qryTp);
    return dto.toEntity();
  }
}
