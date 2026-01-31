import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// 전체 화면 에러 상태를 표시하는 위젯
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.message, required this.onRetry});

  final String message;
  final Future<void> Function({bool showLoading}) onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 36,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              onPressed: () => onRetry(showLoading: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
}
