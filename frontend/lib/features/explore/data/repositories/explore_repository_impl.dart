import 'package:stock_talk/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource _remoteDataSource;

  ExploreRepositoryImpl(this._remoteDataSource);

  @override
  Future<TopMovers> getTopMovers() async {
    final dto = await _remoteDataSource.getTopMovers();
    return dto.toEntity();
  }

  @override
  Future<PopularNewsResponse> getPopularNews() async {
    final dto = await _remoteDataSource.getPopularNews();
    return dto.toEntity();
  }

  @override
  Future<NewsDetail> getNewsDetail(String url) async {
    final dto = await _remoteDataSource.getNewsDetail(url);
    return dto.toEntity();
  }

  @override
  Future<NewsSummary> getNewsSummary(String url) async {
    final dto = await _remoteDataSource.getNewsSummary(url);
    return dto.toEntity();
  }
}
