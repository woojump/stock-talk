class PopularNewsResponse {
  final List<String> targetStocks;
  final List<NewsItem> news;

  const PopularNewsResponse({required this.targetStocks, required this.news});
}

class NewsItem {
  final String title;
  final String pubDate;
  final String stockName;
  final String? description;
  final String? link;

  const NewsItem({
    required this.title,
    required this.pubDate,
    required this.stockName,
    this.description,
    this.link,
  });
}

class NewsDetail {
  final String title;
  final String content;
  final String? topImage;
  final String publishedDate;

  const NewsDetail({
    required this.title,
    required this.content,
    this.topImage,
    required this.publishedDate,
  });
}

class NewsSummary {
  final String aiSummary;

  const NewsSummary({required this.aiSummary});
}
