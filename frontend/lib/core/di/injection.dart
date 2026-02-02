import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/config/api_config.dart';
import 'package:stock_talk/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:stock_talk/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:stock_talk/features/explore/domain/repositories/explore_repository.dart';
import 'package:stock_talk/features/explore/presentation/providers/explore_provider.dart';
import 'package:stock_talk/features/explore/presentation/providers/news_detail_provider.dart';
import 'package:stock_talk/features/explore/data/datasources/stock_detail_remote_data_source.dart';
import 'package:stock_talk/features/explore/data/repositories/stock_detail_repository_impl.dart';
import 'package:stock_talk/features/explore/domain/repositories/stock_detail_repository.dart';
import 'package:stock_talk/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:stock_talk/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:stock_talk/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:stock_talk/features/portfolio/presentation/providers/portfolio_provider.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // 라우팅
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());

  // 네트워크
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  // Portfolio
  getIt.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(getIt<PortfolioRemoteDataSource>()),
  );
  getIt.registerFactory<PortfolioProvider>(
    () => PortfolioProvider(getIt<PortfolioRepository>()),
  );

  // Explore
  getIt.registerLazySingleton<ExploreRemoteDataSource>(
    () => ExploreRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(getIt<ExploreRemoteDataSource>()),
  );
  getIt.registerFactory<ExploreProvider>(
    () => ExploreProvider(getIt<ExploreRepository>()),
  );
  getIt.registerFactory<NewsDetailProvider>(
    () => NewsDetailProvider(getIt<ExploreRepository>()),
  );

  // Stock Detail
  getIt.registerLazySingleton<StockDetailRemoteDataSource>(
    () => StockDetailRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<StockDetailRepository>(
    () => StockDetailRepositoryImpl(getIt<StockDetailRemoteDataSource>()),
  );
}
