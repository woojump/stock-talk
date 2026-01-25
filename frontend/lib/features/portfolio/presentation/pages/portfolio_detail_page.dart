import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';

@RoutePage()
class PortfolioDetailPage extends StatelessWidget {
  const PortfolioDetailPage({super.key, required this.holding});

  final PortfolioHolding holding;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');
    final totalEvaluation = evaluationAmount(holding);
    final totalPurchase = purchaseTotal(holding);
    final totalProfit = profitAmount(holding);
    final profitRate = holding.profitLossRate;
    return Scaffold(
      appBar: AppBar(title: Text(holding.name)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('평가금액', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '${numberFormat.format(totalEvaluation)}원',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(formatProfitText(totalProfit, profitRate, numberFormat)),
            const SizedBox(height: 24),
            _InfoRow(
              label: '총 보유수량',
              value: '${numberFormat.format(holding.quantity)}주',
            ),
            const SizedBox(height: 12),
            _InfoRow(
              label: '총 매수금액',
              value: '${numberFormat.format(totalPurchase)}원',
            ),
            const SizedBox(height: 12),
            _InfoRow(
              label: '평가손익',
              value: formatProfitText(totalProfit, profitRate, numberFormat),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _InfoRow(
              label: '내 평단가',
              value: '${numberFormat.format(holding.purchasePrice)}원',
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: 종목 상세 페이지로 이동
                },
                child: const Text('현재가 보러가기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
