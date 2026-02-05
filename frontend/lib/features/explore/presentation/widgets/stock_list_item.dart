import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/utils/stock_utils.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';

class StockListItem extends StatelessWidget {
  final StockItem stock;
  final int rank;

  const StockListItem({super.key, required this.stock, required this.rank});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');

    return GestureDetector(
      onTap: () {
        context.pushRoute(
          StockDetailRoute(ticker: stock.ticker, stockName: stock.name),
        );
      },
      child: Container(
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
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.gray500),
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${numberFormat.format(stock.price)}원',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stock.ticker,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                      Text(
                        formatChangeText(
                          stock.change,
                          stock.changeRate,
                          numberFormat,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: getProfitColor(stock.change),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
