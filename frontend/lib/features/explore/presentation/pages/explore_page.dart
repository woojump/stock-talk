import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';
import 'package:stock_talk/features/explore/presentation/providers/explore_provider.dart';
import 'package:stock_talk/features/explore/presentation/widgets/chart_section.dart';
import 'package:stock_talk/features/explore/presentation/widgets/news_section.dart';

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ExploreProvider>()..load(),
      child: const _ExplorePageView(),
    );
  }
}

class _ExplorePageView extends StatelessWidget {
  const _ExplorePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: Consumer<ExploreProvider>(
        builder: (context, provider, _) {
          // Show loading only if both are loading and neither has data yet
          if (provider.isLoading &&
              provider.topMovers == null &&
              provider.newsResponse == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show full error only if both failed on initial load
          if (provider.topMoversError != null &&
              provider.newsError != null &&
              provider.topMovers == null &&
              provider.newsResponse == null) {
            return ErrorState(
              message: '데이터를 불러오지 못했어요.',
              onRetry: provider.load,
            );
          }

          // Otherwise, show content (sections handle their own loading/error states)
          return RefreshIndicator(
            onRefresh: provider.refresh,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: AppSpacing.lg),
                const ChartSection(),
                SizedBox(height: AppSpacing.sm),
                Container(height: AppSpacing.sm, color: AppColors.gray100),
                SizedBox(height: AppSpacing.lg),
                const NewsSection(),
                SizedBox(height: 80 + AppSpacing.lg),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        toolbarHeight: 64,
        titleSpacing: 20,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('탐색', style: Theme.of(context).textTheme.displayLarge),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 8),
            child: IconButton(
              icon: AppIcon.action('search'),
              onPressed: () {
                context.router.push(const SearchRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}
