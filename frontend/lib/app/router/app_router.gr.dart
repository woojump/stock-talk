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
/// [ExplorePage]
class ExploreRoute extends PageRouteInfo<void> {
  const ExploreRoute({List<PageRouteInfo>? children})
    : super(ExploreRoute.name, initialChildren: children);

  static const String name = 'ExploreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExplorePage();
    },
  );
}

/// generated route for
/// [MainShellPage]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
    : super(MainShellRoute.name, initialChildren: children);

  static const String name = 'MainShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainShellPage();
    },
  );
}

/// generated route for
/// [PortfolioDetailPage]
class PortfolioDetailRoute extends PageRouteInfo<PortfolioDetailRouteArgs> {
  PortfolioDetailRoute({
    Key? key,
    required PortfolioHolding holding,
    List<PageRouteInfo>? children,
  }) : super(
         PortfolioDetailRoute.name,
         args: PortfolioDetailRouteArgs(key: key, holding: holding),
         initialChildren: children,
       );

  static const String name = 'PortfolioDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PortfolioDetailRouteArgs>();
      return PortfolioDetailPage(key: args.key, holding: args.holding);
    },
  );
}

class PortfolioDetailRouteArgs {
  const PortfolioDetailRouteArgs({this.key, required this.holding});

  final Key? key;

  final PortfolioHolding holding;

  @override
  String toString() {
    return 'PortfolioDetailRouteArgs{key: $key, holding: $holding}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PortfolioDetailRouteArgs) return false;
    return key == other.key && holding == other.holding;
  }

  @override
  int get hashCode => key.hashCode ^ holding.hashCode;
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
