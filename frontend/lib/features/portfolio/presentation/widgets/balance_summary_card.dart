import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';

/// 잔고 요약 카드 위젯
class BalanceSummaryCard extends StatelessWidget {
  const BalanceSummaryCard({
    super.key,
    required this.balance,
    required this.numberFormat,
  });

  final PortfolioBalance balance;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    final availableCash = balance.summary.availableCash;
    final totalAsset = balance.summary.totalAsset;
    final pendingOrderAmount = calculatePendingOrderAmount(balance);

    return SummaryCard(
      items: [
        SummaryItem(
          label: '주문 가능 금액',
          value: '${numberFormat.format(availableCash)}원',
        ),
        SummaryItem(
          label: '미체결 주문 금액',
          value: '${numberFormat.format(pendingOrderAmount)}원',
        ),
        SummaryItem(
          label: '보유 예수금',
          value: '${numberFormat.format(totalAsset)}원',
          isHighlighted: true,
        ),
      ],
    );
  }
}
