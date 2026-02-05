import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';

class NewsCard extends StatelessWidget {
  final NewsItem news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(NewsDetailRoute(news: news));
      },
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              news.description ?? '본문 미리보기 내용',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: AppColors.gray500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
