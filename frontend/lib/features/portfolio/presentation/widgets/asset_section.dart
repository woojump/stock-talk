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
        Text(
          '내 자산',
          style: TextStyle(
            fontSize: AppTypography.titleLarge,
            fontWeight: AppTypography.semiBold,
            color: AppColors.black,
            height: AppTypography.lineHeightBody / AppTypography.titleLarge,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '주식 평가 금액',
          style: TextStyle(
            fontSize: AppTypography.bodyMedium,
            fontWeight: AppTypography.medium,
            color: AppColors.gray600,
            height: AppTypography.lineHeightBody / AppTypography.bodyMedium,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              numberFormat.format(stockEvaluationAmount),
              style: TextStyle(
                fontSize: AppTypography.headlineLarge,
                fontWeight: AppTypography.bold,
                color: AppColors.black,
                height:
                    AppTypography.lineHeightHeadline /
                    AppTypography.headlineLarge,
              ),
            ),
            Text(
              '원',
              style: TextStyle(
                fontSize: AppTypography.titleLarge,
                fontWeight: AppTypography.semiBold,
                color: AppColors.black,
                height: AppTypography.lineHeightBody / AppTypography.titleLarge,
              ),
            ),
          ],
        ),
        Text(
          '$profitSign${numberFormat.format(profit.abs())}원 (${profitRate >= 0 ? '+' : ''}${profitRate.toStringAsFixed(1)}%)',
          style: TextStyle(
            fontSize: AppTypography.bodyMedium,
            fontWeight: AppTypography.medium,
            color: profitColor,
            height: AppTypography.lineHeightBody / AppTypography.bodyMedium,
          ),
        ),
      ],
    );
  }
}
