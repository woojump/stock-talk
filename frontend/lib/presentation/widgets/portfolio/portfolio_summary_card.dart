import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final int totalAssets;
  final int totalProfitLoss;
  final double totalProfitLossPercent;

  const PortfolioSummaryCard({
    super.key,
    required this.totalAssets,
    required this.totalProfitLoss,
    required this.totalProfitLossPercent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,###', 'ko_KR');
    final isProfit = totalProfitLoss > 0;
    final isLoss = totalProfitLoss < 0;
    final profitColor = isProfit
        ? Colors.red
        : isLoss
            ? Colors.blue
            : theme.colorScheme.onSurface;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '총 자산',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${numberFormat.format(totalAssets)}원',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 수익',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isProfit ? '+' : ''}${numberFormat.format(totalProfitLoss)}원',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: profitColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${isProfit ? '+' : ''}${totalProfitLossPercent.toStringAsFixed(2)}%',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: profitColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
