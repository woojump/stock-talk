import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/utils/stock_utils.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';

class StockHeaderSection extends StatelessWidget {
  const StockHeaderSection({
    super.key,
    required this.stockName,
    required this.stockDetail,
  });

  final String stockName;
  final StockDetail? stockDetail;

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat('#,###');

    final currentPrice = stockDetail?.stockInfo.currentPrice ?? 0;
    final priceChange = stockDetail?.priceChange ?? 0;
    final priceChangeRate = stockDetail?.priceChangeRate ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 종목명
        Text(
          stockName,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: AppTypography.semiBold),
        ),
        const SizedBox(height: AppSpacing.md),

        // 현재가
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              priceFormat.format(currentPrice),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: AppTypography.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '원',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: AppTypography.semiBold,
                color: AppColors.black,
              ),
            ),
          ],
        ),

        // 등락폭
        Text(
          formatChangeText(
            priceChange,
            priceChangeRate,
            priceFormat,
            includeUnit: false,
          ),
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: getProfitColor(priceChange)),
        ),
      ],
    );
  }
}
