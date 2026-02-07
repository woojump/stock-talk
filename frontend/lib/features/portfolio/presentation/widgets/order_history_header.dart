import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/presentation/providers/portfolio_provider.dart';

class OrderHistoryHeader extends StatelessWidget {
  const OrderHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('주문 내역', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.lg),
        Consumer<PortfolioProvider>(
          builder: (context, provider, _) {
            return Row(
              children: [
                _TabButton(
                  label: '미체결',
                  isActive: provider.activeTab == 'active',
                  onTap: () => provider.setOrderHistoryTab('active'),
                ),
                const SizedBox(width: AppSpacing.sm),
                _TabButton(
                  label: '완료',
                  isActive: provider.activeTab == 'completed',
                  onTap: () => provider.setOrderHistoryTab('completed'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.black : AppColors.gray100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isActive ? AppColors.white : AppColors.gray500,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
