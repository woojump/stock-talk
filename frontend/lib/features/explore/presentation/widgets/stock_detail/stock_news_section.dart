import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/presentation/widgets/news_card.dart';

class StockNewsSection extends StatelessWidget {
  const StockNewsSection({
    super.key,
    required this.stockNews,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  final List<NewsItem>? stockNews;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 제목
        Text('주요 뉴스', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.lg),

        // 컨텐츠
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading && stockNews == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null && stockNews == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Text(
                error!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  // 13px
                  color: AppColors.gray500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(onPressed: onRetry, child: const Text('다시 시도')),
            ],
          ),
        ),
      );
    }

    if (stockNews == null || stockNews!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            '관련 뉴스가 없습니다',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
          ),
        ),
      );
    }

    // 최대 4개까지만 표시
    final displayNews = stockNews!.take(4).toList();

    return Column(
      children: [
        // 뉴스 카드 목록 (NewsCard 자체적으로 네비게이션 처리)
        ...displayNews.map(
          (news) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: NewsCard(news: news),
          ),
        ),

        // 더보기 버튼
        if (stockNews!.length > 4)
          GestureDetector(
            onTap: () {
              // TODO: 뉴스 전체 목록 페이지로 이동
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '더보기',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: AppTypography.semiBold,
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
