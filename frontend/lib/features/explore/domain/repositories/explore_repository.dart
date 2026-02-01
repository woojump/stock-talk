import 'package:stock_talk/features/explore/domain/entities/explore_entities.dart';

abstract class ExploreRepository {
  Future<TopMovers> getTopMovers();

  Future<PopularNewsResponse> getPopularNews();
}
