import 'package:get_it/get_it.dart';
import 'package:stock_talk/app/router/app_router.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // 라우팅
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}
