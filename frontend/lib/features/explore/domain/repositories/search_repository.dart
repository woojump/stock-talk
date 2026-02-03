import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';

abstract class SearchRepository {
  /// 키워드로 주식 검색
  Future<List<SearchResult>> searchStocks(String query);

  /// 인기 종목 조회
  Future<List<StockItem>> getPopularStocks();

  /// 최근 본 종목 조회 (로컬 저장소)
  List<RecentlyViewedStock> getRecentlyViewedStocks();

  /// 최근 본 종목에 추가 (로컬 저장소)
  Future<void> addRecentlyViewedStock(RecentlyViewedStock stock);
}
