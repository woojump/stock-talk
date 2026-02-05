import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 레이블-값 쌍을 표시하는 범용 요약 카드 위젯
class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.items});

  final List<SummaryItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            if (i == items.length - 1 && items.length > 1) ...[
              const Divider(),
              const SizedBox(height: AppSpacing.md),
            ],
            SummaryItemRow(item: items[i]),
          ],
        ],
      ),
    );
  }
}

/// 요약 카드 내의 개별 행 위젯
class SummaryItemRow extends StatelessWidget {
  const SummaryItemRow({super.key, required this.item});

  final SummaryItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: item.isHighlighted ? AppColors.gray600 : AppColors.gray500,
          ),
        ),
        Text(
          item.value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}

/// 요약 카드 항목 데이터 모델
class SummaryItem {
  const SummaryItem({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  final String label;
  final String value;
  final bool isHighlighted;
}
