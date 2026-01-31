import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/providers/portfolio_provider.dart';
import 'package:stock_talk/features/portfolio/presentation/utils/portfolio_utils.dart';

@RoutePage()
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<PortfolioProvider>()..load(),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ko_KR');

    return Scaffold(
      appBar: AppBar(title: const Text('포트폴리오')),
      body: SafeArea(
        child: Consumer<PortfolioProvider>(
          builder: (context, provider, _) {
            final balance = provider.balance;
            if (provider.isLoading && balance == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage != null && balance == null) {
              return _ErrorState(
                message: provider.errorMessage!,
                onRetry: provider.load,
              );
            }

            if (balance == null) {
              return _ErrorState(
                message: '포트폴리오 정보를 불러오지 못했어요.',
                onRetry: provider.load,
              );
            }

            return RefreshIndicator(
              onRefresh: provider.refresh,
              child: ListView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  if (provider.errorMessage != null)
                    _InlineErrorBanner(message: provider.errorMessage!),
                  _SummarySection(
                    totalAssetValue: totalEvaluationAmount(balance),
                    totalProfitLoss: totalProfitLoss(balance),
                    totalReturnRate: totalReturnRate(balance),
                    numberFormat: numberFormat,
                  ),
                  const SizedBox(height: 24),
                  _HoldingsHeader(count: balance.holdings.length),
                  const SizedBox(height: 12),
                  if (balance.holdings.isEmpty)
                    const _EmptyHoldingsCard()
                  else
                    ...balance.holdings.map(
                      (holding) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _HoldingListItem(
                          holding: holding,
                          numberFormat: numberFormat,
                          onTap: () {
                            context.router.push(
                              PortfolioDetailRoute(holding: holding),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({
    required this.totalAssetValue,
    required this.totalProfitLoss,
    required this.totalReturnRate,
    required this.numberFormat,
  });

  final int totalAssetValue;
  final int totalProfitLoss;
  final double totalReturnRate;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    final profitText = formatProfitText(
      totalProfitLoss,
      totalReturnRate,
      numberFormat,
      includeUnit: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('내 자산', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          '${numberFormat.format(totalAssetValue)}원',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        Text(profitText),
      ],
    );
  }
}

class _HoldingsHeader extends StatelessWidget {
  const _HoldingsHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '보유 종목 ($count)',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _HoldingListItem extends StatelessWidget {
  const _HoldingListItem({
    required this.holding,
    required this.numberFormat,
    this.onTap,
  });

  final PortfolioHolding holding;
  final NumberFormat numberFormat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final totalEvaluation = evaluationAmount(holding);
    final totalProfit = profitAmount(holding);
    final profitText = formatProfitText(
      totalProfit,
      holding.profitLossRate,
      numberFormat,
      includeUnit: true,
    );

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(holding.name),
      subtitle: Text('${numberFormat.format(holding.quantity)}주'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${numberFormat.format(totalEvaluation)}원'),
          const SizedBox(height: 4),
          Text(profitText),
        ],
      ),
    );
  }
}

class _InlineErrorBanner extends StatelessWidget {
  const _InlineErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(message, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

class _EmptyHoldingsCard extends StatelessWidget {
  const _EmptyHoldingsCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: Text('보유 종목이 없습니다.')),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function({bool showLoading}) onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 36, color: Color(0xFFEF4444)),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onRetry(showLoading: true),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
}
