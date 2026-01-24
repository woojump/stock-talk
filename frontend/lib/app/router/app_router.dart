import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/chat/presentation/pages/chat_page.dart';
import 'package:stock_talk/features/explore/presentation/pages/explore_page.dart';
import 'package:stock_talk/features/portfolio/presentation/pages/portfolio_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainShellRoute.page,
      initial: true,
      children: [
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: ExploreRoute.page),
        AutoRoute(page: PortfolioRoute.page),
      ],
    ),
  ];
}

@RoutePage()
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [ChatRoute(), ExploreRoute(), PortfolioRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search),
              label: '탐색',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: '포트폴리오',
            ),
          ],
        );
      },
    );
  }
}
