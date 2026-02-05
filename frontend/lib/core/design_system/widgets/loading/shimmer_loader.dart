import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';

/// Shimmer (스켈레톤) 효과 위젯
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  /// 사각형 형태의 Shimmer
  const AppShimmer.rect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  /// 원형 형태의 Shimmer
  const AppShimmer.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = size / 2;

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                (_animation.value - 0.5).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.5).clamp(0.0, 1.0),
                1.0,
              ],
              colors: [
                AppColors.gray200,
                AppColors.gray200,
                AppColors.gray100,
                AppColors.gray200,
                AppColors.gray200,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 리스트 형태의 스켈레톤 로더
class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({
    super.key,
    this.itemCount = 5,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
  });

  final int itemCount;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.lg),
      itemBuilder: (context, index) => Row(
        children: [
          const AppShimmer.circle(size: 40),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer.rect(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 16,
                ),
                const SizedBox(height: 8),
                AppShimmer.rect(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
