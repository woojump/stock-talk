import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';

class PeriodTabBar extends StatelessWidget {
  const PeriodTabBar({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final ChartPeriod selectedPeriod;
  final ValueChanged<ChartPeriod> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ChartPeriod.values.map((period) {
        final isSelected = period == selectedPeriod;
        // 현재는 '일' 탭만 활성화
        final isEnabled = period == ChartPeriod.day;

        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: GestureDetector(
            onTap: isEnabled ? () => onPeriodChanged(period) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gray200 : AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                period.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: AppTypography.medium,
                  color: isEnabled
                      ? (isSelected ? AppColors.gray700 : AppColors.gray500)
                      : AppColors.gray400,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
