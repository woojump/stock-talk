class SearchResult {
  final String ticker;
  final String name;

  const SearchResult({required this.ticker, required this.name});
}

class RecentlyViewedStock {
  final String ticker;
  final String name;
  final DateTime viewedAt;

  const RecentlyViewedStock({
    required this.ticker,
    required this.name,
    required this.viewedAt,
  });
}
