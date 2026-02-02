import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/explore/presentation/providers/stock_detail_provider.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_detail/stock_header_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_detail/candlestick_chart_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_detail/price_info_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_detail/stock_news_section.dart';

@RoutePage()
class StockDetailPage extends StatelessWidget {
  const StockDetailPage({
    super.key,
    required this.ticker,
    required this.stockName,
  });

  final String ticker;
  final String stockName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<StockDetailProvider>()..load(ticker, stockName),
      child: _StockDetailView(ticker: ticker, stockName: stockName),
    );
  }
}

class _StockDetailView extends StatelessWidget {
  const _StockDetailView({required this.ticker, required this.stockName});

  final String ticker;
  final String stockName;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockDetailProvider>();

    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: AppIcon.action('back', size: 24),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          IconButton(
            icon: AppIcon.action('share', size: 24),
            onPressed: () {
              // TODO: 공유 기능 구현
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.refresh(ticker, stockName),
        child: _buildBody(context, provider),
      ),
    );
  }

  Widget _buildBody(BuildContext context, StockDetailProvider provider) {
    if (provider.isLoading && provider.stockDetail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.detailError != null && provider.stockDetail == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.gray500),
            const SizedBox(height: AppSpacing.md),
            Text(
              provider.detailError!,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: AppTypography.bodyMedium,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => provider.retryStockDetail(ticker),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 주식 헤더 섹션
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: StockHeaderSection(
              stockName: stockName,
              stockDetail: provider.stockDetail,
            ),
          ),

          // 캔들스틱 차트 섹션
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: CandlestickChartSection(
              stockDetail: provider.stockDetail,
              selectedPeriod: provider.selectedPeriod,
              onPeriodChanged: provider.selectPeriod,
            ),
          ),

          // 구분선
          Container(height: 8, color: AppColors.gray100),

          // 시세 정보 섹션
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: PriceInfoSection(stockDetail: provider.stockDetail),
          ),

          // 구분선
          Container(height: 8, color: AppColors.gray100),

          // 뉴스 섹션
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: StockNewsSection(
              stockNews: provider.stockNews,
              isLoading: provider.newsLoading,
              error: provider.newsError,
              onRetry: () => provider.retryStockNews(stockName),
            ),
          ),

          // 하단 여백
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}
