import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/presentation/providers/news_detail_provider.dart';
import 'package:stock_talk/features/explore/presentation/utils/explore_utils.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<NewsDetailProvider>()..loadNewsDetail(news.link!),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              _TopBar(
                onShare: () => {
                  // TODO: 공유 기능 구현
                },
              ),
              Expanded(
                child: Consumer<NewsDetailProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoadingDetail) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.detailError != null) {
                      return _NewsDetailErrorState(
                        message: provider.detailError!,
                        newsUrl: news.link,
                        onRetry: ({bool showLoading = true}) =>
                            provider.retryDetail(news.link!),
                      );
                    }

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppSpacing.xl),
                          _SourceLabel(source: _extractSource(news.link)),
                          SizedBox(height: AppSpacing.lg),
                          _Headline(title: news.title),
                          SizedBox(height: AppSpacing.xs),
                          _PublishDate(pubDate: news.pubDate),
                          SizedBox(height: AppSpacing.xxxl),
                          _AISummaryCard(
                            summary: provider.newsSummary,
                            isLoading: provider.isLoadingSummary,
                            error: provider.summaryError,
                          ),
                          SizedBox(height: AppSpacing.xl),
                          _ArticleContent(
                            content: provider.newsDetail!.content,
                          ),
                          SizedBox(height: AppSpacing.huge),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _extractSource(String? url) {
    if (url == null) return '출처';
    final uri = Uri.tryParse(url);
    if (uri == null) return '출처';
    return uri.host.replaceAll('www.', '').replaceAll('.com', '');
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onShare;
  const _TopBar({required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.router.pop(),
            child: AppIcon.action('back', size: 24),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onShare,
            child: AppIcon.action('share', size: 24),
          ),
        ],
      ),
    );
  }
}

class _SourceLabel extends StatelessWidget {
  final String source;
  const _SourceLabel({required this.source});

  @override
  Widget build(BuildContext context) {
    return Text(
      '출처($source)',
      style: TextStyle(
        fontSize: AppTypography.titleMedium,
        fontWeight: AppTypography.semiBold,
        color: AppColors.gray700,
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  final String title;
  const _Headline({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: AppTypography.semiBold,
        color: AppColors.black,
        height: 1.64,
      ),
    );
  }
}

class _PublishDate extends StatelessWidget {
  final String pubDate;
  const _PublishDate({required this.pubDate});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        formatNewsPublishDate(pubDate),
        style: TextStyle(
          fontSize: AppTypography.labelSmall,
          fontWeight: AppTypography.regular,
          color: AppColors.gray500,
          height: 1.273,
        ),
      ),
    );
  }
}

class _AISummaryCard extends StatelessWidget {
  final NewsSummary? summary;
  final bool isLoading;
  final String? error;

  const _AISummaryCard({
    required this.summary,
    required this.isLoading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI 요약',
              style: TextStyle(
                fontSize: AppTypography.labelSmall,
                fontWeight: AppTypography.regular,
                color: AppColors.gray500,
                height: 1.273,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '핵심요약 헤드라인',
                  style: TextStyle(
                    fontSize: AppTypography.titleMedium,
                    fontWeight: AppTypography.semiBold,
                    color: AppColors.black,
                  ),
                ),
                // 드롭다운 아이콘 (펼쳐진 상태이므로 회전)
                Transform.rotate(
                  angle: 3.14159, // 180도
                  child: AppIcon.action('dropdown', size: 16.67),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (error != null)
              Text(
                error!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: AppTypography.medium,
                  color: AppColors.red,
                  height: 1.6,
                ),
              )
            else if (summary != null)
              Text(
                summary!.aiSummary,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: AppTypography.medium,
                  color: AppColors.black,
                  height: 1.6,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  final String content;
  const _ArticleContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        content,
        style: TextStyle(
          fontSize: AppTypography.titleMedium,
          fontWeight: AppTypography.medium,
          color: AppColors.black,
          height: 1.6,
        ),
      ),
    );
  }
}

// 뉴스 상세 에러 상태 (원본 링크 제공)
class _NewsDetailErrorState extends StatelessWidget {
  final String message;
  final String? newsUrl;
  final Future<void> Function({bool showLoading}) onRetry;

  const _NewsDetailErrorState({
    required this.message,
    required this.newsUrl,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '일부 기사는 원문에서만 볼 수 있습니다',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray500),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (newsUrl != null)
              PrimaryButton(
                onPressed: () => _launchUrl(newsUrl!),
                child: const Text('원문 기사 보기'),
              ),
            const SizedBox(height: AppSpacing.md),
            SecondaryButton(
              onPressed: () => onRetry(showLoading: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
