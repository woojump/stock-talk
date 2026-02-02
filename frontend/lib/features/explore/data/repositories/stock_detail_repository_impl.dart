import 'package:stock_talk/features/explore/data/datasources/stock_detail_remote_data_source.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/stock_detail_repository.dart';

class StockDetailRepositoryImpl implements StockDetailRepository {
  final StockDetailRemoteDataSource _remoteDataSource;

  StockDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<StockDetail> getStockDetail(String ticker) async {
    final dto = await _remoteDataSource.getStockDetail(ticker);
    return dto.toEntity();
  }

  @override
  Future<List<NewsItem>> getStockNews(String stockName) async {
    final dtoList = await _remoteDataSource.getStockNews(stockName);
    return dtoList
        .map(
          (dto) => NewsItem(
            title: dto.title,
            pubDate: dto.pubDate ?? '',
            stockName: stockName,
            description: dto.description,
            link: dto.link,
          ),
        )
        .toList();
  }
}
