/// 주식 상세 정보
class StockDetail {
  final String ticker;
  final StockInfo stockInfo;
  final List<Candle> candles;

  const StockDetail({
    required this.ticker,
    required this.stockInfo,
    required this.candles,
  });

  /// 첫 번째 캔들의 시가
  double get openPrice => candles.isNotEmpty ? candles.first.open : 0;

  /// 마지막 캔들의 종가
  double get closePrice => candles.isNotEmpty ? candles.last.close : 0;

  /// 전체 캔들 중 최고가
  double get highPrice {
    if (candles.isEmpty) return 0;
    return candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);
  }

  /// 전체 캔들 중 최저가
  double get lowPrice {
    if (candles.isEmpty) return 0;
    return candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
  }

  /// 전체 거래량 합계
  int get totalVolume {
    if (candles.isEmpty) return 0;
    return candles.map((c) => c.volume).reduce((a, b) => a + b);
  }

  /// 가격 변동 (종가 - 시가)
  double get priceChange => closePrice - openPrice;

  /// 가격 변동률 (%)
  double get priceChangeRate {
    if (openPrice == 0) return 0;
    return (priceChange / openPrice) * 100;
  }

  /// 가격이 상승했는지 여부
  bool get isPositive => priceChange >= 0;
}

/// 현재 주식 시세 정보
class StockInfo {
  final double currentPrice;
  final int totalAskQty;
  final int totalBidQty;

  const StockInfo({
    required this.currentPrice,
    required this.totalAskQty,
    required this.totalBidQty,
  });
}

/// 캔들스틱 데이터
class Candle {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  const Candle({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  /// 양봉인지 여부 (종가 >= 시가)
  bool get isBullish => close >= open;
}

/// 차트 기간 타입
enum ChartPeriod {
  day('일'),
  week('주'),
  month('월'),
  year('년');

  final String label;
  const ChartPeriod(this.label);
}
