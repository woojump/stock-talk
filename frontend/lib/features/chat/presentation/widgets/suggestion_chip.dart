import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 랜딩 페이지 제안 칩
class SuggestionChip extends StatelessWidget {
  const SuggestionChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 265),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: AppTypography.titleMedium,
            fontWeight: AppTypography.medium,
            color: AppColors.gray800,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
