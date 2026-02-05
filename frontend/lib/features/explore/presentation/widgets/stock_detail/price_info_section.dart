import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';

class PriceInfoSection extends StatelessWidget {
  const PriceInfoSection({super.key, required this.stockDetail});

  final StockDetail? stockDetail;

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat('#,###');

    final lowPrice = stockDetail?.lowPrice ?? 0;
    final highPrice = stockDetail?.highPrice ?? 0;
    final openPrice = stockDetail?.openPrice ?? 0;
    final closePrice = stockDetail?.closePrice ?? 0;
    final volume = stockDetail?.totalVolume ?? 0;
    final currentPrice = stockDetail?.stockInfo.currentPrice ?? 0;

    // 현재가 위치 계산 (0~1 사이)
    final priceRange = highPrice - lowPrice;
    final pricePosition = priceRange > 0
        ? (currentPrice - lowPrice) / priceRange
        : 0.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 제목
        Text(
          '시세',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: AppTypography.semiBold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 1일 가격 범위 바
        _buildPriceRangeBar(
          context,
          label: '1일',
          lowPrice: lowPrice,
          highPrice: highPrice,
          currentPosition: pricePosition,
          priceFormat: priceFormat,
        ),
        const SizedBox(height: AppSpacing.lg),

        // 시작가 / 종가 / 거래량
        _buildInfoGrid(
          context,
          openPrice: openPrice,
          closePrice: closePrice,
          volume: volume,
          priceFormat: priceFormat,
        ),
      ],
    );
  }

  Widget _buildPriceRangeBar(
    BuildContext context, {
    required String label,
    required double lowPrice,
    required double highPrice,
    required double currentPosition,
    required NumberFormat priceFormat,
  }) {
    return Column(
      children: [
        // 프로그레스 바
        Stack(
          children: [
            // 배경 바
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // 현재가 위치 표시
            Positioned(
              left: 0,
              right: 0,
              height: 8,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final position = currentPosition.clamp(0.0, 1.0);
                  final leftOffset = constraints.maxWidth * position - 4;
                  return SizedBox(
                    height: 8,
                    child: Stack(
                      children: [
                        Positioned(
                          left: leftOffset.clamp(0.0, constraints.maxWidth - 8),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.blue300,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // 최저가 / 최고가 라벨
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriceLabel(context, '$label 최저가', lowPrice, priceFormat),
            _buildPriceLabel(context, '$label 최고가', highPrice, priceFormat),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),

        // 가격 값
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPriceValue(context, lowPrice, priceFormat),
            _buildPriceValue(context, highPrice, priceFormat),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceLabel(
    BuildContext context,
    String label,
    double price,
    NumberFormat format,
  ) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: AppTypography.regular,
        color: AppColors.gray500,
      ),
    );
  }

  Widget _buildPriceValue(
    BuildContext context,
    double price,
    NumberFormat format,
  ) {
    return Text(
      '${format.format(price)}원',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: AppTypography.regular,
        color: AppColors.gray500,
      ),
    );
  }

  Widget _buildInfoGrid(
    BuildContext context, {
    required double openPrice,
    required double closePrice,
    required int volume,
    required NumberFormat priceFormat,
  }) {
    final volumeFormat = NumberFormat('#,###');

    return Row(
      children: [
        // 왼쪽 컬럼
        Expanded(
          child: Column(
            children: [
              _buildInfoRow(
                context,
                '시작가',
                '${priceFormat.format(openPrice)}원',
              ),
              const SizedBox(height: AppSpacing.xs),
              _buildInfoRow(
                context,
                '종가',
                '${priceFormat.format(closePrice)}원',
              ),
            ],
          ),
        ),
        // 구분선
        Container(
          width: 1,
          height: 38,
          color: AppColors.gray300,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        // 오른쪽 컬럼
        Expanded(
          child: Column(
            children: [
              _buildInfoRow(context, '거래량', '${volumeFormat.format(volume)}주'),
              const SizedBox(height: AppSpacing.xs),
              _buildInfoRow(context, '거래대금', '-'), // API 미지원
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: AppTypography.regular,
            color: AppColors.gray500,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: AppTypography.regular,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
