import 'package:dio/dio.dart';
import 'package:stock_talk/core/config/api_config.dart';
import 'package:stock_talk/features/explore/data/dto/news_dto.dart';
import 'package:stock_talk/features/explore/data/dto/top_movers_dto.dart';

class ExploreRemoteDataSource {
  final Dio _dio;

  ExploreRemoteDataSource(this._dio);

  Future<TopMoversDto> getTopMovers() async {
    final response = await _dio.get(ApiConfig.topMoversPath);

    if (response.data == null) {
      throw Exception('No data received from top-movers endpoint');
    }

    return TopMoversDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<PopularNewsResponseDto> getPopularNews() async {
    final response = await _dio.get(ApiConfig.popularNewsPath);

    if (response.data == null) {
      throw Exception('No data received from popular news endpoint');
    }

    return PopularNewsResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<NewsDetailDto> getNewsDetail(String url) async {
    final response = await _dio.get(
      ApiConfig.newsDetailPath,
      queryParameters: {'url': url},
    );

    if (response.data == null) {
      throw Exception('No data received from news detail endpoint');
    }

    return NewsDetailDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<NewsSummaryDto> getNewsSummary(String url) async {
    final response = await _dio.get(
      ApiConfig.newsSummaryPath,
      queryParameters: {'url': url},
    );

    if (response.data == null) {
      throw Exception('No data received from news summary endpoint');
    }

    return NewsSummaryDto.fromJson(response.data as Map<String, dynamic>);
  }
}
