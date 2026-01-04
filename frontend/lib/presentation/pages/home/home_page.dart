import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/router/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        ChatRoute(),
        StockSearchRoute(),
        PortfolioRoute(),
      ],
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
              label: '종목검색',
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
