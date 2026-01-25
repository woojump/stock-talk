import 'package:dio/dio.dart';
import 'package:stock_talk/core/config/api_config.dart';
import 'package:stock_talk/features/portfolio/data/dto/portfolio_balance_dto.dart';

class PortfolioRemoteDataSource {
  PortfolioRemoteDataSource(this._dio);

  final Dio _dio;

  Future<PortfolioBalanceDto> fetchBalance() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConfig.balancePath,
    );
    final data = response.data;
    if (data == null) {
      throw StateError('Empty response from ${ApiConfig.balancePath}');
    }
    return PortfolioBalanceDto.fromJson(data);
  }
}
