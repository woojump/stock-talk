import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/explore/presentation/providers/search_provider.dart';
import 'package:stock_talk/features/explore/presentation/widgets/search/popular_stocks_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/search/recently_viewed_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/search/search_app_bar.dart';
import 'package:stock_talk/features/explore/presentation/widgets/search/search_result_item.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<SearchProvider>()..load(),
      child: const _SearchPageView(),
    );
  }
}

class _SearchPageView extends StatefulWidget {
  const _SearchPageView();

  @override
  State<_SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<_SearchPageView> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SearchAppBar(
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: (query) {
          context.read<SearchProvider>().onQueryChanged(query);
        },
        onClear: () {
          _searchController.clear();
          context.read<SearchProvider>().clearSearch();
        },
        onBack: () => context.router.maybePop(),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, _) {
          return _buildBody(context, provider);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchProvider provider) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _buildBodyContent(context, provider),
    );
  }

  Widget _buildBodyContent(BuildContext context, SearchProvider provider) {
    switch (provider.state) {
      case SearchState.initial:
        return _buildLandingContent(context, provider);
      case SearchState.searching:
        return const Center(child: CircularProgressIndicator());
      case SearchState.results:
        return _buildSearchResults(context, provider);
      case SearchState.noResults:
        return _buildNoResults();
    }
  }

  Widget _buildLandingContent(BuildContext context, SearchProvider provider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          if (provider.recentlyViewed.isNotEmpty) ...[
            RecentlyViewedSection(
              stocks: provider.recentlyViewed,
              onStockTap: (stock) => _navigateToStockDetail(
                context,
                provider,
                stock.ticker,
                stock.name,
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
          ],
          PopularStocksSection(
            stocks: provider.popularStocks,
            isLoading: provider.popularLoading,
            error: provider.popularError,
            onStockTap: (stock) => _navigateToStockDetail(
              context,
              provider,
              stock.ticker,
              stock.name,
            ),
            onRetry: provider.retryPopularStocks,
            onSeeMore: () {
              // TODO: 더보기 기능 구현
            },
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: provider.searchResults.length,
      itemBuilder: (context, index) {
        final result = provider.searchResults[index];
        return SearchResultItem(
          result: result,
          query: provider.query,
          onTap: () => _navigateToStockDetail(
            context,
            provider,
            result.ticker,
            result.name,
          ),
        );
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Text(
        '검색 결과가 없어요',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.gray400,
          fontWeight: AppTypography.medium,
        ),
      ),
    );
  }

  void _navigateToStockDetail(
    BuildContext context,
    SearchProvider provider,
    String ticker,
    String name,
  ) {
    provider.addToRecentlyViewed(ticker, name);
    context.pushRoute(StockDetailRoute(ticker: ticker, stockName: name));
  }
}
