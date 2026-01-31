import 'package:flutter/material.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/design_system/design_system.dart';
import 'package:stock_talk/core/di/injection.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stock Talk',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
