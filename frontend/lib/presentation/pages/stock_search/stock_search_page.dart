import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/router/app_router.dart';
import '../../providers/stock_search_provider.dart';
import '../../widgets/common/error_widget.dart' as app;
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/stock/stock_list_tile.dart';
import '../../widgets/stock/stock_search_bar.dart';

@RoutePage()
class StockSearchPage extends StatefulWidget {
  const StockSearchPage({super.key});

  @override
  State<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockSearchProvider>().loadPopularStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('종목 검색'),
      ),
      body: Column(
        children: [
          Consumer<StockSearchProvider>(
            builder: (context, provider, _) => StockSearchBar(
              initialQuery: provider.query,
              onSearch: (query) => provider.search(query),
              onClear: () => provider.clearSearch(),
            ),
          ),
          Expanded(
            child: Consumer<StockSearchProvider>(
              builder: (context, provider, _) {
                if (provider.hasQuery) {
                  return _buildSearchResults(provider);
                } else {
                  return _buildPopularStocks(provider);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(StockSearchProvider provider) {
    switch (provider.status) {
      case StockSearchStatus.loading:
        return const LoadingIndicator();
      case StockSearchStatus.error:
        return app.AppErrorWidget(
          message: provider.errorMessage ?? '검색 중 오류가 발생했습니다',
          onRetry: () => provider.search(provider.query),
        );
      case StockSearchStatus.loaded:
        if (!provider.hasResults) {
          return _buildEmptyState('검색 결과가 없습니다');
        }
        return ListView.separated(
          itemCount: provider.searchResults.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final stock = provider.searchResults[index];
            return StockListTile(
              stock: stock,
              onTap: () => context.router.push(StockDetailRoute(code: stock.code)),
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPopularStocks(StockSearchProvider provider) {
    if (provider.popularStocks.isEmpty) {
      return _buildEmptyState('종목명 또는 종목코드를 검색하세요');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '인기 종목',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: provider.popularStocks.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final stock = provider.popularStocks[index];
              return StockListTile(
                stock: stock,
                onTap: () => context.router.push(StockDetailRoute(code: stock.code)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
