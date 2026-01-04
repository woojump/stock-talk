import 'package:flutter/foundation.dart';

import '../../core/di/injection.dart';
import '../../domain/entities/stock.dart';
import '../../domain/repositories/i_stock_repository.dart';

enum StockSearchStatus { initial, loading, loaded, error }

class StockSearchProvider extends ChangeNotifier {
  final IStockRepository _repository = getIt<IStockRepository>();

  StockSearchStatus _status = StockSearchStatus.initial;
  List<Stock> _searchResults = [];
  List<Stock> _popularStocks = [];
  String _query = '';
  String? _errorMessage;

  StockSearchStatus get status => _status;
  List<Stock> get searchResults => _searchResults;
  List<Stock> get popularStocks => _popularStocks;
  String get query => _query;
  String? get errorMessage => _errorMessage;

  bool get hasQuery => _query.isNotEmpty;
  bool get hasResults => _searchResults.isNotEmpty;

  Future<void> loadPopularStocks() async {
    try {
      _popularStocks = await _repository.getPopularStocks();
      notifyListeners();
    } catch (e) {
      // Silently fail for popular stocks
    }
  }

  Future<void> search(String query) async {
    _query = query;

    if (query.isEmpty) {
      _searchResults = [];
      _status = StockSearchStatus.initial;
      notifyListeners();
      return;
    }

    _status = StockSearchStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _repository.searchStocks(query);
      _status = StockSearchStatus.loaded;
    } catch (e) {
      _status = StockSearchStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _searchResults = [];
    _status = StockSearchStatus.initial;
    notifyListeners();
  }
}
