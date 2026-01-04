import 'package:flutter/foundation.dart';

import '../../core/di/injection.dart';
import '../../domain/entities/portfolio_item.dart';
import '../../domain/repositories/i_portfolio_repository.dart';

enum PortfolioStatus { initial, loading, loaded, error }

class PortfolioProvider extends ChangeNotifier {
  final IPortfolioRepository _repository = getIt<IPortfolioRepository>();

  PortfolioStatus _status = PortfolioStatus.initial;
  List<PortfolioItem> _items = [];
  int _totalAssets = 0;
  int _totalProfitLoss = 0;
  double _totalProfitLossPercent = 0.0;
  String? _errorMessage;

  PortfolioStatus get status => _status;
  List<PortfolioItem> get items => _items;
  int get totalAssets => _totalAssets;
  int get totalProfitLoss => _totalProfitLoss;
  double get totalProfitLossPercent => _totalProfitLossPercent;
  String? get errorMessage => _errorMessage;

  bool get isProfit => _totalProfitLoss > 0;
  bool get isLoss => _totalProfitLoss < 0;

  Future<void> loadPortfolio() async {
    _status = PortfolioStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getPortfolio(),
        _repository.getTotalAssets(),
        _repository.getTotalProfitLoss(),
        _repository.getTotalProfitLossPercent(),
      ]);

      _items = results[0] as List<PortfolioItem>;
      _totalAssets = results[1] as int;
      _totalProfitLoss = results[2] as int;
      _totalProfitLossPercent = results[3] as double;
      _status = PortfolioStatus.loaded;
    } catch (e) {
      _status = PortfolioStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    await loadPortfolio();
  }
}
