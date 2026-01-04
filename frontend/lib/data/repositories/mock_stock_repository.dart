import '../../domain/entities/stock.dart';
import '../../domain/repositories/i_stock_repository.dart';

class MockStockRepository implements IStockRepository {
  final List<Stock> _mockStocks = const [
    Stock(
      code: '005930',
      name: '삼성전자',
      currentPrice: 71500,
      previousClose: 71000,
      change: 500,
      changePercent: 0.70,
      volume: 12345678,
      high: 72000,
      low: 70500,
      open: 71000,
    ),
    Stock(
      code: '000660',
      name: 'SK하이닉스',
      currentPrice: 178000,
      previousClose: 180000,
      change: -2000,
      changePercent: -1.11,
      volume: 3456789,
      high: 181000,
      low: 177000,
      open: 180000,
    ),
    Stock(
      code: '035420',
      name: 'NAVER',
      currentPrice: 215000,
      previousClose: 212000,
      change: 3000,
      changePercent: 1.42,
      volume: 987654,
      high: 217000,
      low: 211000,
      open: 212500,
    ),
    Stock(
      code: '035720',
      name: '카카오',
      currentPrice: 48500,
      previousClose: 49000,
      change: -500,
      changePercent: -1.02,
      volume: 2345678,
      high: 49500,
      low: 48000,
      open: 49000,
    ),
    Stock(
      code: '051910',
      name: 'LG화학',
      currentPrice: 385000,
      previousClose: 382000,
      change: 3000,
      changePercent: 0.79,
      volume: 234567,
      high: 388000,
      low: 380000,
      open: 382000,
    ),
    Stock(
      code: '006400',
      name: '삼성SDI',
      currentPrice: 412000,
      previousClose: 415000,
      change: -3000,
      changePercent: -0.72,
      volume: 345678,
      high: 418000,
      low: 410000,
      open: 415000,
    ),
    Stock(
      code: '068270',
      name: '셀트리온',
      currentPrice: 178500,
      previousClose: 176000,
      change: 2500,
      changePercent: 1.42,
      volume: 567890,
      high: 180000,
      low: 175000,
      open: 176500,
    ),
    Stock(
      code: '105560',
      name: 'KB금융',
      currentPrice: 58900,
      previousClose: 58500,
      change: 400,
      changePercent: 0.68,
      volume: 789012,
      high: 59500,
      low: 58200,
      open: 58500,
    ),
    Stock(
      code: '055550',
      name: '신한지주',
      currentPrice: 41200,
      previousClose: 41500,
      change: -300,
      changePercent: -0.72,
      volume: 456789,
      high: 41800,
      low: 41000,
      open: 41500,
    ),
    Stock(
      code: '066570',
      name: 'LG전자',
      currentPrice: 98500,
      previousClose: 97000,
      change: 1500,
      changePercent: 1.55,
      volume: 678901,
      high: 99000,
      low: 96500,
      open: 97000,
    ),
  ];

  @override
  Future<List<Stock>> searchStocks(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase();
    return _mockStocks.where((stock) {
      return stock.name.toLowerCase().contains(lowerQuery) ||
          stock.code.contains(query);
    }).toList();
  }

  @override
  Future<Stock> getStockDetail(String code) async {
    await Future.delayed(const Duration(milliseconds: 200));

    return _mockStocks.firstWhere(
      (stock) => stock.code == code,
      orElse: () => throw Exception('Stock not found: $code'),
    );
  }

  @override
  Future<List<Stock>> getPopularStocks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockStocks.take(5).toList();
  }
}
