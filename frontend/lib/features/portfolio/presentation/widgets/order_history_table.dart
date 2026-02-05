import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/order_history_row.dart';

class OrderHistoryTable extends StatelessWidget {
  const OrderHistoryTable({required this.orders, super.key});

  final List<OrderHistoryItem> orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 테이블 헤더
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  '종목명',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 60,
                child: Text(
                  '주문구분',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 30,
                child: Text(
                  '주문수량',
                  textAlign: TextAlign.right,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 30,
                child: Text(
                  '체결수량',
                  textAlign: TextAlign.right,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 70,
                child: Text(
                  '주문시간',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 60,
                child: Text(
                  '상태',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.gray500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 구분선
          Container(height: 1, width: 396, color: AppColors.gray300),
          const SizedBox(height: 12),
          // 주문 리스트
          ...orders.map(
            (order) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: OrderHistoryRow(item: order),
            ),
          ),
        ],
      ),
    );
  }
}
