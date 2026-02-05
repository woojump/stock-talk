import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';

abstract class StockDetailRepository {
  /// 주식 상세 정보 및 캔들 데이터 조회
  Future<StockDetail> getStockDetail(String ticker);

  /// 특정 종목 관련 뉴스 조회
  Future<List<NewsItem>> getStockNews(String stockName);
}
