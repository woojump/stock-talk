import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/stock.dart';
import 'stock_price_display.dart';

class StockListTile extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const StockListTile({
    super.key,
    required this.stock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            stock.name.substring(0, 1),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      title: Text(
        stock.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        stock.code,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${numberFormat.format(stock.currentPrice)}원',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          StockPriceDisplay(
            change: stock.change,
            changePercent: stock.changePercent,
          ),
        ],
      ),
    );
  }
}
