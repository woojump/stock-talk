import 'package:flutter/material.dart';

class OrderHistoryHeader extends StatelessWidget {
  const OrderHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('주문 내역', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
