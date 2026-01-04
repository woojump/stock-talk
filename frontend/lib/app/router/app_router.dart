import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/chat/chat_page.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';
import 'package:frontend/presentation/pages/portfolio/portfolio_page.dart';
import 'package:frontend/presentation/pages/stock_search/stock_detail_page.dart';
import 'package:frontend/presentation/pages/stock_search/stock_search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          children: [
            AutoRoute(path: 'chat', page: ChatRoute.page),
            AutoRoute(path: 'search', page: StockSearchRoute.page),
            AutoRoute(path: 'portfolio', page: PortfolioRoute.page),
          ],
        ),
        AutoRoute(path: '/stock/:code', page: StockDetailRoute.page),
      ];
}
