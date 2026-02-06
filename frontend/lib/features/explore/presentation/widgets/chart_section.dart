import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/presentation/providers/explore_provider.dart';
import 'package:stock_talk/features/explore/presentation/widgets/chart_tab.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_list_item.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('실시간 차트', style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: AppSpacing.lg),
          _buildTabBar(),
          SizedBox(height: AppSpacing.lg),
          _buildStockList(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Consumer<ExploreProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChartTabWidget(
                label: '급상승',
                isSelected: provider.selectedTab == ChartTab.up,
                onTap: () => provider.selectTab(ChartTab.up),
              ),
              SizedBox(width: AppSpacing.sm),
              ChartTabWidget(
                label: '급하락',
                isSelected: provider.selectedTab == ChartTab.down,
                onTap: () => provider.selectTab(ChartTab.down),
              ),
              SizedBox(width: AppSpacing.sm),
              ChartTabWidget(
                label: '인기',
                isSelected: provider.selectedTab == ChartTab.popular,
                onTap: () => provider.selectTab(ChartTab.popular),
              ),
              SizedBox(width: AppSpacing.sm),
              ChartTabWidget(
                label: '기관 순매수',
                isSelected: provider.selectedTab == ChartTab.buy,
                onTap: () => provider.selectTab(ChartTab.buy),
              ),
              SizedBox(width: AppSpacing.sm),
              ChartTabWidget(
                label: '기관 순매도',
                isSelected: provider.selectedTab == ChartTab.sell,
                onTap: () => provider.selectTab(ChartTab.sell),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStockList() {
    return Consumer<ExploreProvider>(
      builder: (context, provider, _) {
        // Show loading state
        if (provider.topMoversLoading && provider.topMovers == null) {
          return const AppSkeletonList(
            itemCount: 5,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          );
        }

        // Show error state with retry
        if (provider.topMoversError != null && provider.topMovers == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    provider.topMoversError!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.md),
                  TextButton(
                    onPressed: provider.retryTopMovers,
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
        final stocks = provider.currentStockList;

        return Column(
          children: [
            ...stocks
                .take(5)
                .map(
                  (stock) => Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: StockListItem(
                      stock: stock,
                      rank: stocks.indexOf(stock) + 1,
                    ),
                  ),
                ),
            // SizedBox(height: AppSpacing.sm),
            // Center(
            //   child: SecondaryButton(
            //     onPressed: null, // TODO: 더보기 기능 구현
            //     child: const Text('더보기'),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
