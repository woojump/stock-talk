import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';

@RoutePage()
class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('뉴스 상세')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('뉴스 상세 페이지'),
            const SizedBox(height: 16),
            Text('제목: ${news.title}'),
          ],
        ),
      ),
    );
  }
}
