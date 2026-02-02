import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';

abstract class ExploreRepository {
  Future<TopMovers> getTopMovers();

  Future<PopularNewsResponse> getPopularNews();

  Future<NewsDetail> getNewsDetail(String url);

  Future<NewsSummary> getNewsSummary(String url);
}
