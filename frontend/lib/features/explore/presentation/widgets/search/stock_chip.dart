import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

class StockChip extends StatelessWidget {
  const StockChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: AppTypography.medium,
            color: AppColors.gray500,
          ),
        ),
      ),
    );
  }
}
