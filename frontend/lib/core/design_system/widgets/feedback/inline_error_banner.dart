import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 인라인 에러 메시지를 표시하는 배너 위젯
class InlineErrorBanner extends StatelessWidget {
  const InlineErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Text(message, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
