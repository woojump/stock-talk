import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 보유 종목 헤더 위젯
class HoldingsHeader extends StatelessWidget {
  const HoldingsHeader({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '보유 종목',
          style: TextStyle(
            fontSize: AppTypography.titleLarge,
            fontWeight: AppTypography.semiBold,
            color: AppColors.black,
            height: AppTypography.lineHeightBody / AppTypography.titleLarge,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: TextStyle(
            fontSize: AppTypography.bodySmall,
            fontWeight: AppTypography.regular,
            color: AppColors.gray400,
            height: AppTypography.lineHeightBodySmall / AppTypography.bodySmall,
          ),
        ),
      ],
    );
  }
}
