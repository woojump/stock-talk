import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart'
    as utils;

class OrderHistoryRow extends StatelessWidget {
  const OrderHistoryRow({required this.item, super.key});

  final OrderHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final isBuy = item.side.contains('매수');
    final sideColor = isBuy ? AppColors.red : AppColors.blue400;

    return Row(
      children: [
        // 종목명
        SizedBox(
          width: 80,
          child: Text(item.name, style: Theme.of(context).textTheme.labelLarge),
        ),
        const SizedBox(width: 12),
        // 주문구분
        SizedBox(
          width: 60,
          child: Text(
            item.side,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: sideColor),
          ),
        ),
        const SizedBox(width: 12),
        // 주문수량
        SizedBox(
          width: 30,
          child: Text(
            item.ordQty.toString(),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(width: 12),
        // 체결수량
        SizedBox(
          width: 30,
          child: Text(
            item.cntrQty.toString(),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(width: 12),
        // 주문시간 (날짜 포함)
        SizedBox(
          width: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.ordDt.length == 8)
                Text(
                  '${item.ordDt.substring(4, 6)}.${item.ordDt.substring(6, 8)}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.gray400),
                ),
              Text(
                utils.formatOrderTime(item.ordTm),
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.gray600),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // 상태
        SizedBox(
          width: 60,
          child: Text(
            item.status,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.gray600),
          ),
        ),
      ],
    );
  }
}
