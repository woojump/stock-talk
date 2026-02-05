import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';

/// 내 자산 섹션 위젯
class AssetSection extends StatelessWidget {
  const AssetSection({
    super.key,
    required this.stockEvaluationAmount,
    required this.totalProfitLoss,
    required this.totalReturnRate,
    required this.numberFormat,
  });

  final int stockEvaluationAmount;
  final int totalProfitLoss;
  final double totalReturnRate;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    final profit = totalProfitLoss;
    final profitRate = totalReturnRate;
    final profitSign = profit >= 0 ? '+' : '';
    final profitColor = getProfitColor(profit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('내 자산', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 20),
        Text(
          '주식 평가 금액',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.gray600),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              numberFormat.format(stockEvaluationAmount),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: AppTypography.bold,
              ),
            ),
            Text('원', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Text(
          '$profitSign${numberFormat.format(profit.abs())}원 (${profitRate >= 0 ? '+' : ''}${profitRate.toStringAsFixed(1)}%)',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: profitColor),
        ),
      ],
    );
  }
}
