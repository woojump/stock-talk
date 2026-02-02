import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/utils/stock_utils.dart';
import 'package:stock_talk/features/explore/domain/entities/explore_entities.dart';

class StockListItem extends StatelessWidget {
  final StockItem stock;
  final int rank;

  const StockListItem({super.key, required this.stock, required this.rank});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: AppTypography.labelSmall,
                fontWeight: AppTypography.regular,
                color: AppColors.gray500,
                height:
                    AppTypography.lineHeightBodySmall /
                    AppTypography.labelSmall,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.name,
                      style: TextStyle(
                        fontSize: AppTypography.titleMedium,
                        fontWeight: AppTypography.semiBold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      '${numberFormat.format(stock.price)}원',
                      style: TextStyle(
                        fontSize: AppTypography.titleMedium,
                        fontWeight: AppTypography.medium,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.ticker,
                      style: TextStyle(
                        fontSize: AppTypography.labelSmall,
                        fontWeight: AppTypography.regular,
                        color: AppColors.gray500,
                        height:
                            AppTypography.lineHeightBodySmall /
                            AppTypography.labelSmall,
                      ),
                    ),
                    Text(
                      formatChangeText(
                        stock.change,
                        stock.changeRate,
                        numberFormat,
                      ),
                      style: TextStyle(
                        fontSize: AppTypography.labelSmall,
                        fontWeight: AppTypography.regular,
                        color: getProfitColor(stock.change),
                        height:
                            AppTypography.lineHeightBodySmall /
                            AppTypography.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
