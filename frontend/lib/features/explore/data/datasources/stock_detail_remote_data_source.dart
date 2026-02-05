import 'package:dio/dio.dart';
import 'package:stock_talk/core/config/api_config.dart';
import 'package:stock_talk/features/explore/data/dto/stock_detail_dto.dart';

class StockDetailRemoteDataSource {
  final Dio _dio;

  StockDetailRemoteDataSource(this._dio);

  /// 주식 상세 정보 및 캔들 데이터 조회
  /// GET /market/stock/{ticker}/detail
  Future<StockDetailResponseDto> getStockDetail(String ticker) async {
    final response = await _dio.get(
      '${ApiConfig.stockDetailPath}/$ticker/detail',
    );

    if (response.data == null) {
      throw Exception('No data received from stock detail endpoint');
    }

    return StockDetailResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  /// 특정 종목 관련 뉴스 조회
  /// GET /news/stock?name={name}
  Future<List<StockNewsItemDto>> getStockNews(String stockName) async {
    final response = await _dio.get(
      ApiConfig.stockNewsPath,
      queryParameters: {'name': stockName},
    );

    if (response.data == null) {
      throw Exception('No data received from stock news endpoint');
    }

    final List<dynamic> jsonList = response.data as List<dynamic>;
    return jsonList
        .map((item) => StockNewsItemDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
