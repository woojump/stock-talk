import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/portfolio/presentation/providers/portfolio_provider.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/asset_section.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/balance_summary_card.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/holdings_header.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/stock_card.dart';

@RoutePage()
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<PortfolioProvider>()..load(),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          '포트폴리오',
          style: TextStyle(
            fontSize: AppTypography.headlineMedium,
            fontWeight: AppTypography.semiBold,
            color: AppColors.black,
            height:
                AppTypography.lineHeightHeadline / AppTypography.headlineMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<PortfolioProvider>(
          builder: (context, provider, _) {
            final balance = provider.balance;
            if (provider.isLoading && balance == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage != null && balance == null) {
              return ErrorState(
                message: provider.errorMessage!,
                onRetry: provider.load,
              );
            }

            if (balance == null) {
              return ErrorState(
                message: '포트폴리오 정보를 불러오지 못했어요.',
                onRetry: provider.load,
              );
            }

            return RefreshIndicator(
              onRefresh: provider.refresh,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // 내 자산 섹션
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (provider.errorMessage != null)
                          InlineErrorBanner(message: provider.errorMessage!),
                        AssetSection(
                          stockEvaluationAmount: totalEvaluationAmount(balance),
                          totalProfitLoss: totalProfitLoss(balance),
                          totalReturnRate: calculateStockReturnRate(balance),
                          numberFormat: numberFormat,
                        ),
                        const SizedBox(height: 20),
                        BalanceSummaryCard(
                          balance: balance,
                          numberFormat: numberFormat,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 구분선
                  Container(height: 8, color: AppColors.gray100),
                  const SizedBox(height: 32),
                  // 보유 종목 섹션
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HoldingsHeader(count: balance.holdings.length),
                        const SizedBox(height: 16),
                        if (balance.holdings.isEmpty)
                          const EmptyState(message: '보유 종목이 없습니다.')
                        else
                          ...balance.holdings.map((holding) {
                            final profit = profitAmount(holding);
                            final profitRate = holding.profitLossRate;
                            final profitColor = getProfitColor(profit);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: StockCard(
                                name: holding.name,
                                quantity:
                                    '${numberFormat.format(holding.quantity)}주',
                                evaluationAmount:
                                    '${numberFormat.format(evaluationAmount(holding))}원',
                                profitText: formatProfitText(
                                  profit,
                                  profitRate,
                                  numberFormat,
                                  includeUnit: true,
                                ),
                                profitColor: profitColor,
                                onTap: () {
                                  context.router.push(
                                    PortfolioDetailRoute(holding: holding),
                                  );
                                },
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
