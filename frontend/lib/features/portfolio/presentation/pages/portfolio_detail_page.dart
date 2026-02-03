import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';

@RoutePage()
class PortfolioDetailPage extends StatelessWidget {
  const PortfolioDetailPage({super.key, required this.holding});

  final PortfolioHolding holding;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');
    final totalEvaluation = evaluationAmount(holding);
    final totalPurchase = purchaseTotal(holding);
    final totalProfit = profitAmount(holding);
    final profitRate = holding.profitLossRate;

    return Scaffold(
      appBar: AppBar(title: Text(holding.name), centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          children: [
            // Top Section - Evaluation Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '평가금액',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: AppTypography.semiBold,
                    color: AppColors.black,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      numberFormat.format(totalEvaluation),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: AppTypography.bold,
                        color: AppColors.black,
                        height: 1.64,
                      ),
                    ),
                    Text(
                      '원',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: AppTypography.semiBold,
                        color: AppColors.black,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xxxxl),

            // Middle Section - Metrics
            Column(
              children: [
                // First Metrics Group
                _MetricRow(
                  label: '총 보유수량',
                  value: '${numberFormat.format(holding.quantity)}주',
                ),
                const SizedBox(height: AppSpacing.md),
                _MetricRow(
                  label: '총 매수금액',
                  value: '${numberFormat.format(totalPurchase)}원',
                ),
                const SizedBox(height: AppSpacing.md),
                _MetricRow(
                  label: '평가손익',
                  value: formatProfitText(
                    totalProfit,
                    profitRate,
                    numberFormat,
                  ),
                  valueColor: getProfitColor(totalProfit),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Divider
                const Divider(
                  color: AppColors.gray300,
                  thickness: 1,
                  height: 1,
                ),

                const SizedBox(height: AppSpacing.lg),

                // Second Metrics Group
                _MetricRow(
                  label: '내 평단가',
                  value: '${numberFormat.format(holding.purchasePrice)}원',
                ),
                const SizedBox(height: AppSpacing.md),
                _MetricRow(
                  label: '현재가',
                  value: '${numberFormat.format(holding.currentPrice)}원',
                ),

                const SizedBox(height: AppSpacing.lg),

                // Action Button
                Center(
                  child: SecondaryButton(
                    onPressed: () {
                      context.pushRoute(
                        StockDetailRoute(
                          ticker: holding.ticker,
                          stockName: holding.name,
                        ),
                      );
                    },
                    child: const Text('현재가 보러가기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppTypography.bodyMedium,
            fontWeight: AppTypography.medium,
            color: AppColors.gray500,
            height: 1.6,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: AppTypography.bodyMedium,
            fontWeight: AppTypography.medium,
            color: valueColor ?? AppColors.black,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
