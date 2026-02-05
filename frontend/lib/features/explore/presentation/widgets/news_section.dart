import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/presentation/providers/explore_provider.dart';
import 'package:stock_talk/features/explore/presentation/widgets/news_card.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('인기 뉴스', style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: AppSpacing.lg),
          _buildNewsList(),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return Consumer<ExploreProvider>(
      builder: (context, provider, _) {
        // Show loading state
        if (provider.newsLoading && provider.newsResponse == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show error state with retry
        if (provider.newsError != null && provider.newsResponse == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    provider.newsError!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: provider.retryNews,
                    child: Text(
                      '다시 시도',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.blue400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show content
        final newsItems = provider.newsResponse?.news ?? [];

        return Column(
          children: [
            ...newsItems
                .take(4)
                .map(
                  (news) => Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: NewsCard(news: news),
                  ),
                ),
            SizedBox(height: AppSpacing.sm),
            Center(
              child: SecondaryButton(
                onPressed: null, // TODO: 더보기 기능 구현
                child: const Text('더보기'),
              ),
            ),
          ],
        );
      },
    );
  }
}
