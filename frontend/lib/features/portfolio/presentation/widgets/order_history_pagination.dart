import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

class OrderHistoryPagination extends StatelessWidget {
  const OrderHistoryPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    super.key,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 0) return const SizedBox.shrink();

    final int startPage = ((currentPage - 1) ~/ 5) * 5 + 1;
    final int endPage = (startPage + 4).clamp(1, totalPages);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 이전 버튼
        GestureDetector(
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          behavior: HitTestBehavior.opaque,
          child: AppIcon.action(
            'back',
            size: 16,
            color: currentPage > 1 ? AppColors.gray600 : AppColors.gray400,
          ),
        ),
        const SizedBox(width: 20),
        // 페이지 번호들
        ...List.generate(endPage - startPage + 1, (index) {
          final page = startPage + index;
          final isActive = page == currentPage;
          return GestureDetector(
            onTap: () => onPageChanged(page),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                page.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isActive ? AppColors.gray600 : AppColors.gray400,
                  fontWeight: isActive
                      ? AppTypography.semiBold
                      : AppTypography.medium,
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 20),
        // 다음 버튼
        GestureDetector(
          onTap: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
          behavior: HitTestBehavior.opaque,
          child: AppIcon.action(
            'next',
            size: 16,
            color: currentPage < totalPages
                ? AppColors.gray600
                : AppColors.gray400,
          ),
        ),
      ],
    );
  }
}
