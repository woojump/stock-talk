import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/portfolio_item.dart';

class PortfolioItemCard extends StatelessWidget {
  final PortfolioItem item;
  final VoidCallback? onTap;

  const PortfolioItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final numberFormat = NumberFormat('#,###', 'ko_KR');
    final profitColor = item.isProfit
        ? Colors.red
        : item.isLoss
            ? Colors.blue
            : theme.colorScheme.onSurface;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.stockName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.stockCode,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${numberFormat.format(item.currentPrice)}원',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.isProfit ? '+' : ''}${item.profitLossPercent.toStringAsFixed(2)}%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: profitColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(
                    context,
                    '보유수량',
                    '${numberFormat.format(item.quantity)}주',
                  ),
                  _buildInfoItem(
                    context,
                    '평균매입가',
                    '${numberFormat.format(item.averagePrice)}원',
                  ),
                  _buildInfoItem(
                    context,
                    '평가손익',
                    '${item.isProfit ? '+' : ''}${numberFormat.format(item.profitLoss)}원',
                    valueColor: profitColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
