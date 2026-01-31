import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/features/chat/presentation/pages/chat_page.dart';
import 'package:stock_talk/features/explore/presentation/pages/explore_page.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/presentation/pages/portfolio_detail_page.dart';
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

    // Portfolio
    AutoRoute(page: PortfolioDetailRoute.page),
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
          items: [
            BottomNavigationBarItem(
              icon: AppIcon.nav('chat', active: false),
              activeIcon: AppIcon.nav('chat', active: true),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: AppIcon.nav('explore', active: false),
              activeIcon: AppIcon.nav('explore', active: true),
              label: '탐색',
            ),
            BottomNavigationBarItem(
              icon: AppIcon.nav('portfolio', active: false),
              activeIcon: AppIcon.nav('portfolio', active: true),
              label: '포트폴리오',
            ),
          ],
        );
      },
    );
  }
}
