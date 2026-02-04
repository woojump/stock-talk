import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/domain/entities/chat_entities.dart';

/// 종목 정보 카드
class StockInfoCard extends StatelessWidget {
  const StockInfoCard({super.key, required this.payload});

  final StockCardPayload payload;

  @override
  Widget build(BuildContext context) {
    final summary = payload.summary;
    if (summary == null) {
      return const SizedBox.shrink();
    }

    final priceFormat = NumberFormat('#,###');
    final changeColor = summary.isPositive ? AppColors.red : AppColors.blue400;
    final changeSign = summary.isPositive ? '+' : '';

    return Container(
      width: 291,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더: 종목명, 티커, 드롭다운
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        summary.stockName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: AppTypography.titleMedium,
                          fontWeight: AppTypography.semiBold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      summary.ticker,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 13,
                        fontWeight: AppTypography.regular,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              const AppIcon.action('dropdown', size: 12),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),

          // 가격 정보
          Row(
            children: [
              Text(
                priceFormat.format(summary.currentPrice),
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: AppTypography.titleMedium,
                  fontWeight: AppTypography.semiBold,
                  color: AppColors.black,
                ),
              ),
              const Text(
                '원',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: AppTypography.titleMedium,
                  fontWeight: AppTypography.medium,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$changeSign${priceFormat.format(summary.priceChange)}원 ($changeSign${summary.priceChangePercent.toStringAsFixed(1)}%)',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: AppTypography.regular,
                  color: changeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // 차트
          if (payload.candles != null && payload.candles!.isNotEmpty)
            _StockChart(
              candles: payload.candles!,
              isPositive: summary.isPositive,
            )
          else
            _ChartPlaceholder(),
        ],
      ),
    );
  }
}

/// 주식 차트
class _StockChart extends StatelessWidget {
  const _StockChart({required this.candles, required this.isPositive});

  final List<CandleData> candles;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final spots = candles.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.close);
    }).toList();

    final minY = candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
    final maxY = candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;

    return SizedBox(
      height: 100,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minY: minY - padding,
          maxY: maxY + padding,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.2,
              color: isPositive ? AppColors.red : AppColors.blue400,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: (isPositive ? AppColors.red : AppColors.blue400)
                    .withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: const LineTouchData(enabled: false),
        ),
      ),
    );
  }
}

/// 차트 플레이스홀더
class _ChartPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: Text(
          '차트 데이터 없음',
          style: TextStyle(color: AppColors.gray500, fontSize: 12),
        ),
      ),
    );
  }
}
