import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/explore/domain/entities/explore_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/explore_repository.dart';

enum ChartTab { up, down, popular, buy, sell }

class ExploreProvider extends ChangeNotifier {
  ExploreProvider(this._repository);

  final ExploreRepository _repository;

  TopMovers? _topMovers;
  PopularNewsResponse? _newsResponse;
  bool _topMoversLoading = false;
  bool _newsLoading = false;
  String? _topMoversError;
  String? _newsError;
  ChartTab _selectedTab = ChartTab.up;

  TopMovers? get topMovers => _topMovers;
  PopularNewsResponse? get newsResponse => _newsResponse;
  bool get topMoversLoading => _topMoversLoading;
  bool get newsLoading => _newsLoading;
  String? get topMoversError => _topMoversError;
  String? get newsError => _newsError;
  ChartTab get selectedTab => _selectedTab;

  bool get isLoading => _topMoversLoading || _newsLoading;

  String? get errorMessage => _topMoversError ?? _newsError;

  List<StockItem> get currentStockList {
    if (_topMovers == null) return [];

    switch (_selectedTab) {
      case ChartTab.up:
        return _topMovers!.up;
      case ChartTab.down:
        return _topMovers!.down;
      case ChartTab.popular:
        return _topMovers!.popular;
      case ChartTab.buy:
        return _topMovers!.buy;
      case ChartTab.sell:
        return _topMovers!.sell;
    }
  }

  void selectTab(ChartTab tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  Future<void> _loadTopMovers({bool showLoading = true}) async {
    if (_topMoversLoading) return;

    if (showLoading) {
      _topMoversLoading = true;
      notifyListeners();
    }

    try {
      _topMovers = await _repository.getTopMovers();
      _topMoversError = null;
    } catch (error) {
      _topMoversError = _mapError(error);
    } finally {
      _topMoversLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadNews({bool showLoading = true}) async {
    if (_newsLoading) return;

    if (showLoading) {
      _newsLoading = true;
      notifyListeners();
    }

    try {
      _newsResponse = await _repository.getPopularNews();
      _newsError = null;
    } catch (error) {
      _newsError = _mapError(error);
    } finally {
      _newsLoading = false;
      notifyListeners();
    }
  }

  /// api 병렬 호출
  Future<void> load({bool showLoading = true}) async {
    await Future.wait([
      _loadTopMovers(showLoading: showLoading),
      _loadNews(showLoading: showLoading),
    ]);
  }

  Future<void> refresh() async {
    await load(showLoading: false);
  }

  Future<void> retryTopMovers() async {
    await _loadTopMovers();
  }

  Future<void> retryNews() async {
    await _loadNews();
  }

  String _mapError(Object error) {
    debugPrint('ExploreProvider Error: $error');
    if (error is DioException) {
      debugPrint('DioException Type: ${error.type}');
      debugPrint('DioException Response: ${error.response?.data}');
      debugPrint('DioException Message: ${error.message}');
      return error.message ?? '데이터를 불러오지 못했어요.';
    }
    debugPrint('Error Type: ${error.runtimeType}');
    debugPrint('Error String: ${error.toString()}');
    return '데이터를 불러오지 못했어요: ${error.toString()}';
  }
}
