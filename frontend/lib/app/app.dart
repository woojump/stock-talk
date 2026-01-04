import 'package:flutter/material.dart';
import 'package:frontend/app/router/app_router.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/presentation/providers/chat_provider.dart';
import 'package:frontend/presentation/providers/portfolio_provider.dart';
import 'package:frontend/presentation/providers/stock_search_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => PortfolioProvider()),
        ChangeNotifierProvider(create: (_) => StockSearchProvider()),
      ],
      child: MaterialApp.router(
        title: 'MCP Mock Invest',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
