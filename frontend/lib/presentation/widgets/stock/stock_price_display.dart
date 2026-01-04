import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockPriceDisplay extends StatelessWidget {
  final int change;
  final double changePercent;
  final bool showIcon;

  const StockPriceDisplay({
    super.key,
    required this.change,
    required this.changePercent,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    final isUp = change > 0;
    final isDown = change < 0;

    Color color;
    IconData? icon;
    String sign;

    if (isUp) {
      color = Colors.red;
      icon = Icons.arrow_drop_up;
      sign = '+';
    } else if (isDown) {
      color = Colors.blue;
      icon = Icons.arrow_drop_down;
      sign = '';
    } else {
      color = Colors.grey;
      icon = null;
      sign = '';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon && icon != null)
          Icon(
            icon,
            color: color,
            size: 20,
          ),
        Text(
          '$sign${numberFormat.format(change)}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($sign${changePercent.toStringAsFixed(2)}%)',
          style: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
