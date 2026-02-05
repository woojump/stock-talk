import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/utils/stock_utils.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';

class PopularStocksSection extends StatelessWidget {
  const PopularStocksSection({
    super.key,
    required this.stocks,
    required this.isLoading,
    required this.error,
    required this.onStockTap,
    required this.onRetry,
    required this.onSeeMore,
  });

  final List<StockItem> stocks;
  final bool isLoading;
  final String? error;
  final void Function(StockItem) onStockTap;
  final VoidCallback onRetry;
  final VoidCallback onSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('인기 종목', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.lg),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading && stocks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xxxl),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null && stocks.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text(
              error!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: onRetry,
              child: Text(
                '다시 시도',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.blue400),
              ),
            ),
          ],
        ),
      );
    }

    final numberFormat = NumberFormat.decimalPattern('ko_KR');
    final displayStocks = stocks.take(5).toList();

    return Column(
      children: [
        ...displayStocks.asMap().entries.map((entry) {
          final index = entry.key;
          final stock = entry.value;
          return _PopularStockItem(
            stock: stock,
            rank: index + 1,
            numberFormat: numberFormat,
            onTap: () => onStockTap(stock),
          );
        }),
        // const SizedBox(height: AppSpacing.md),
        // Center(
        //   child: GestureDetector(
        //     onTap: onSeeMore,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: AppSpacing.md,
        //         vertical: AppSpacing.xs,
        //       ),
        //       decoration: BoxDecoration(
        //         color: AppColors.gray100,
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: Text(
        //         '더보기',
        //         style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //           fontWeight: AppTypography.semiBold,
        //           color: AppColors.gray400,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _PopularStockItem extends StatelessWidget {
  const _PopularStockItem({
    required this.stock,
    required this.rank,
    required this.numberFormat,
    required this.onTap,
  });

  final StockItem stock;
  final int rank;
  final NumberFormat numberFormat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
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
                        '${numberFormat.format(stock.price.toInt())}원',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
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
