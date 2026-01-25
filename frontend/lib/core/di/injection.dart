import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_talk/app/router/app_router.dart';
import 'package:stock_talk/core/config/api_config.dart';

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
}
