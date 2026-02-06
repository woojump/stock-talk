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
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quantity,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.gray600),
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
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profitText,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: profitColor),
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
