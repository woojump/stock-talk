import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 주식 카드 위젯
class StockCard extends StatelessWidget {
  const StockCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.evaluationAmount,
    required this.profitText,
    required this.profitColor,
    this.onTap,
  });

  final String name;
  final String quantity;
  final String evaluationAmount;
  final String profitText;
  final Color profitColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // Left side: 종목명과 수량
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: AppTypography.bodyMedium,
                        fontWeight: AppTypography.semiBold,
                        color: AppColors.black,
                        height:
                            AppTypography.lineHeightBody /
                            AppTypography.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quantity,
                      style: TextStyle(
                        fontSize: AppTypography.labelSmall,
                        fontWeight: AppTypography.regular,
                        color: AppColors.gray600,
                        height:
                            AppTypography.lineHeightBodySmall /
                            AppTypography.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              // Right side: 평가액과 손익
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    evaluationAmount,
                    style: TextStyle(
                      fontSize: AppTypography.bodyMedium,
                      fontWeight: AppTypography.medium,
                      color: AppColors.black,
                      height:
                          AppTypography.lineHeightBody /
                          AppTypography.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profitText,
                    style: TextStyle(
                      fontSize: AppTypography.labelSmall,
                      fontWeight: AppTypography.regular,
                      color: profitColor,
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
      ),
    );
  }
}
