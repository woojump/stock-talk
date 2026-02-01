import 'package:stock_talk/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:stock_talk/features/explore/domain/entities/explore_entities.dart';
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
}
