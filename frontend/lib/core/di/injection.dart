import 'package:get_it/get_it.dart';

import '../../data/repositories/mock_chat_repository.dart';
import '../../data/repositories/mock_portfolio_repository.dart';
import '../../data/repositories/mock_stock_repository.dart';
import '../../domain/repositories/i_chat_repository.dart';
import '../../domain/repositories/i_portfolio_repository.dart';
import '../../domain/repositories/i_stock_repository.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repositories
  getIt.registerLazySingleton<IStockRepository>(
    () => MockStockRepository(),
  );

  getIt.registerLazySingleton<IPortfolioRepository>(
    () => MockPortfolioRepository(),
  );

  getIt.registerLazySingleton<IChatRepository>(
    () => MockChatRepository(),
  );
}
