import 'package:stock_talk/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:stock_talk/features/explore/data/datasources/search_local_data_source.dart';
import 'package:stock_talk/features/explore/data/dto/recently_viewed_stock_dto.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ExploreRemoteDataSource _remoteDataSource;
  final SearchLocalDataSource _localDataSource;

  SearchRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<SearchResult>> searchStocks(String query) async {
    final dtos = await _remoteDataSource.searchStocks(query);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<StockItem>> getPopularStocks() async {
    final topMovers = await _remoteDataSource.getTopMovers();
    return topMovers.toEntity().popular;
  }

  @override
  List<RecentlyViewedStock> getRecentlyViewedStocks() {
    return _localDataSource
        .getRecentlyViewedStocks()
        .map((dto) => dto.toEntity())
        .toList();
  }

  @override
  Future<void> addRecentlyViewedStock(RecentlyViewedStock stock) async {
    final dto = RecentlyViewedStockDto(
      ticker: stock.ticker,
      name: stock.name,
      viewedAt: stock.viewedAt.toIso8601String(),
    );
    await _localDataSource.addRecentlyViewedStock(dto);
  }
}
