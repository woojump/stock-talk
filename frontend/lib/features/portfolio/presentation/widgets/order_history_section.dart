import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/portfolio/presentation/providers/portfolio_provider.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/order_history_header.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/order_history_pagination.dart';
import 'package:stock_talk/features/portfolio/presentation/widgets/order_history_table.dart';

class OrderHistorySection extends StatefulWidget {
  const OrderHistorySection({super.key});

  @override
  State<OrderHistorySection> createState() => _OrderHistorySectionState();
}

class _OrderHistorySectionState extends State<OrderHistorySection> {
  @override
  void initState() {
    super.initState();
    // 초기 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PortfolioProvider>().loadOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 구분선
        Container(height: 8, color: AppColors.gray100),
        const SizedBox(height: 32),
        // 주문 내역 섹션
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OrderHistoryHeader(),
              const SizedBox(height: 20),
              Consumer<PortfolioProvider>(
                builder: (context, provider, _) {
                  // 로딩 상태
                  if (provider.isLoadingOrders &&
                      provider.orderHistory == null) {
                    return const AppSkeletonTable(rowCount: 5);
                  }

                  // 에러 상태
                  if (provider.orderErrorMessage != null &&
                      provider.orderHistory == null) {
                    return InlineErrorBanner(
                      message: provider.orderErrorMessage!,
                    );
                  }

                  final filteredOrders = provider.filteredOrders;

                  // 빈 데이터 (현재 탭 기준)
                  if (filteredOrders.isEmpty) {
                    return const EmptyState(message: '내역이 없습니다.');
                  }

                  return Column(
                    children: [
                      // 페이지네이션
                      OrderHistoryPagination(
                        currentPage: provider.currentPage,
                        totalPages: provider.totalPages,
                        onPageChanged: provider.setPage,
                      ),
                      const SizedBox(height: 32),
                      // 테이블
                      OrderHistoryTable(orders: provider.currentPageOrders),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
