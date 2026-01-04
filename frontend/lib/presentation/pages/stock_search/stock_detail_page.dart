import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/di/injection.dart';
import '../../../domain/entities/stock.dart';
import '../../../domain/repositories/i_stock_repository.dart';
import '../../widgets/common/error_widget.dart' as app;
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/stock/stock_price_display.dart';

@RoutePage()
class StockDetailPage extends StatefulWidget {
  final String code;

  const StockDetailPage({
    super.key,
    @PathParam('code') required this.code,
  });

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  final IStockRepository _repository = getIt<IStockRepository>();

  Stock? _stock;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadStock();
  }

  Future<void> _loadStock() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final stock = await _repository.getStockDetail(widget.code);
      setState(() {
        _stock = stock;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_stock?.name ?? '종목 상세'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator();
    }

    if (_errorMessage != null) {
      return app.AppErrorWidget(
        message: _errorMessage!,
        onRetry: _loadStock,
      );
    }

    if (_stock == null) {
      return const Center(child: Text('종목 정보를 찾을 수 없습니다'));
    }

    return _buildStockDetail(_stock!);
  }

  Widget _buildStockDetail(Stock stock) {
    final numberFormat = NumberFormat('#,###');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceHeader(stock, numberFormat),
          const SizedBox(height: 24),
          _buildPriceInfoCard(stock, numberFormat),
          const SizedBox(height: 16),
          _buildTradingInfoCard(stock, numberFormat),
        ],
      ),
    );
  }

  Widget _buildPriceHeader(Stock stock, NumberFormat numberFormat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      stock.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stock.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stock.code,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '${numberFormat.format(stock.currentPrice)}원',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            StockPriceDisplay(
              change: stock.change,
              changePercent: stock.changePercent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfoCard(Stock stock, NumberFormat numberFormat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '가격 정보',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('시가', '${numberFormat.format(stock.open)}원'),
            _buildInfoRow('고가', '${numberFormat.format(stock.high)}원',
                valueColor: Colors.red),
            _buildInfoRow('저가', '${numberFormat.format(stock.low)}원',
                valueColor: Colors.blue),
            _buildInfoRow('전일 종가', '${numberFormat.format(stock.previousClose)}원'),
          ],
        ),
      ),
    );
  }

  Widget _buildTradingInfoCard(Stock stock, NumberFormat numberFormat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '거래 정보',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('거래량', '${numberFormat.format(stock.volume)}주'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
