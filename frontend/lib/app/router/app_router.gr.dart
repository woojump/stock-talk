// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [PortfolioPage]
class PortfolioRoute extends PageRouteInfo<void> {
  const PortfolioRoute({List<PageRouteInfo>? children})
    : super(PortfolioRoute.name, initialChildren: children);

  static const String name = 'PortfolioRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PortfolioPage();
    },
  );
}

/// generated route for
/// [StockDetailPage]
class StockDetailRoute extends PageRouteInfo<StockDetailRouteArgs> {
  StockDetailRoute({
    Key? key,
    required String code,
    List<PageRouteInfo>? children,
  }) : super(
         StockDetailRoute.name,
         args: StockDetailRouteArgs(key: key, code: code),
         rawPathParams: {'code': code},
         initialChildren: children,
       );

  static const String name = 'StockDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<StockDetailRouteArgs>(
        orElse: () => StockDetailRouteArgs(code: pathParams.getString('code')),
      );
      return StockDetailPage(key: args.key, code: args.code);
    },
  );
}

class StockDetailRouteArgs {
  const StockDetailRouteArgs({this.key, required this.code});

  final Key? key;

  final String code;

  @override
  String toString() {
    return 'StockDetailRouteArgs{key: $key, code: $code}';
  }
}

/// generated route for
/// [StockSearchPage]
class StockSearchRoute extends PageRouteInfo<void> {
  const StockSearchRoute({List<PageRouteInfo>? children})
    : super(StockSearchRoute.name, initialChildren: children);

  static const String name = 'StockSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StockSearchPage();
    },
  );
}
