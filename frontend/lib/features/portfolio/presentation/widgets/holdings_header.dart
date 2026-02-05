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
        Text('보유 종목', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.gray400),
        ),
      ],
    );
  }
}
