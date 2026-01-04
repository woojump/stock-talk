import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/portfolio_provider.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/portfolio/portfolio_item_card.dart';
import '../../widgets/portfolio/portfolio_summary_card.dart';

@RoutePage()
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PortfolioProvider>().loadPortfolio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('포트폴리오'),
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, provider, child) {
          return switch (provider.status) {
            PortfolioStatus.initial ||
            PortfolioStatus.loading =>
              const LoadingIndicator(message: '포트폴리오를 불러오는 중...'),
            PortfolioStatus.error => AppErrorWidget(
                message: provider.errorMessage ?? '알 수 없는 오류가 발생했습니다',
                onRetry: () => provider.loadPortfolio(),
              ),
            PortfolioStatus.loaded => RefreshIndicator(
                onRefresh: () => provider.refresh(),
                child: ListView(
                  children: [
                    PortfolioSummaryCard(
                      totalAssets: provider.totalAssets,
                      totalProfitLoss: provider.totalProfitLoss,
                      totalProfitLossPercent: provider.totalProfitLossPercent,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '보유 종목 (${provider.items.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...provider.items.map(
                      (item) => PortfolioItemCard(item: item),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
