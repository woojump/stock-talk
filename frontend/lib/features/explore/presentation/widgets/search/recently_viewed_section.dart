import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';
import 'package:stock_talk/features/explore/presentation/widgets/search/stock_chip.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({
    super.key,
    required this.stocks,
    required this.onStockTap,
  });

  final List<RecentlyViewedStock> stocks;
  final void Function(RecentlyViewedStock) onStockTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Text(
            '최근 본 종목',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Row(
            children: stocks.map((stock) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: StockChip(
                  label: stock.name,
                  onTap: () => onStockTap(stock),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
