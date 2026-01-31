import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 빈 상태를 표시하는 범용 위젯
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Center(child: Text(message)),
    );
  }
}
