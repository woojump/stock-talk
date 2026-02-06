import 'package:candlesticks/candlesticks.dart' as charts;
import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';
import 'package:stock_talk/features/explore/presentation/widgets/stock_detail/period_tab_bar.dart';

class CandlestickChartSection extends StatelessWidget {
  const CandlestickChartSection({
    super.key,
    required this.stockDetail,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final StockDetail? stockDetail;
  final ChartPeriod selectedPeriod;
  final ValueChanged<ChartPeriod> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 차트 영역
        SizedBox(height: 320, child: _buildChart(context)),
        const SizedBox(height: AppSpacing.xl),

        // 기간 탭 바
        PeriodTabBar(
          selectedPeriod: selectedPeriod,
          onPeriodChanged: onPeriodChanged,
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    if (stockDetail == null || stockDetail!.candles.isEmpty) {
      return Center(
        child: Text(
          '차트 데이터가 없습니다',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
        ),
      );
    }

    // Candle 엔티티를 candlesticks 패키지의 Candle로 변환
    final candles = stockDetail!.candles.map((candle) {
      return charts.Candle(
        date: candle.time,
        open: candle.open,
        high: candle.high,
        low: candle.low,
        close: candle.close,
        volume: candle.volume.toDouble(),
      );
    }).toList();

    // 날짜 기준 내림차순 정렬 (최신이 먼저)
    candles.sort((a, b) => b.date.compareTo(a.date));

    return charts.Candlesticks(candles: candles, actions: const []);
  }
}
