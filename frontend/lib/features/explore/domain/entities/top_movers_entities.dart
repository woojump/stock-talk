/// 카테고리별 상위종목
class TopMovers {
  final List<StockItem> up;
  final List<StockItem> down;
  final List<StockItem> popular;
  final List<StockItem> buy;
  final List<StockItem> sell;

  const TopMovers({
    required this.up,
    required this.down,
    required this.popular,
    required this.buy,
    required this.sell,
  });
}

/// 개별 주식 항목
class StockItem {
  final String name;
  final String ticker;
  final double price;
  final double change;
  final double changeRate;

  const StockItem({
    required this.name,
    required this.ticker,
    required this.price,
    required this.change,
    required this.changeRate,
  });
}
