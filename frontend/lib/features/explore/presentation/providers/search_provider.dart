import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_talk/features/explore/domain/entities/search_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/top_movers_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/search_repository.dart';

enum SearchState { initial, searching, results, noResults }

class SearchProvider extends ChangeNotifier {
  SearchProvider(this._repository);

  final SearchRepository _repository;

  // State
  SearchState _state = SearchState.initial;
  String _query = '';
  List<SearchResult> _searchResults = [];
  List<RecentlyViewedStock> _recentlyViewed = [];
  List<StockItem> _popularStocks = [];
  bool _popularLoading = false;
  String? _popularError;
  String? _searchError;

  // Debounce timer
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 300);

  // Getters
  SearchState get state => _state;
  String get query => _query;
  List<SearchResult> get searchResults => _searchResults;
  List<RecentlyViewedStock> get recentlyViewed => _recentlyViewed;
  List<StockItem> get popularStocks => _popularStocks;
  bool get popularLoading => _popularLoading;
  String? get popularError => _popularError;
  String? get searchError => _searchError;
  bool get isSearching => _state == SearchState.searching;
  bool get hasQuery => _query.isNotEmpty;

  /// 초기 로딩 (최근 본 종목 및 인기 종목)
  Future<void> load() async {
    _loadRecentlyViewed();
    await _loadPopularStocks();
  }

  void _loadRecentlyViewed() {
    _recentlyViewed = _repository.getRecentlyViewedStocks();
    notifyListeners();
  }

  Future<void> _loadPopularStocks() async {
    _popularLoading = true;
    _popularError = null;
    notifyListeners();

    try {
      _popularStocks = await _repository.getPopularStocks();
    } catch (error) {
      _popularError = _mapError(error);
    } finally {
      _popularLoading = false;
      notifyListeners();
    }
  }

  void onQueryChanged(String query) {
    _query = query;
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _state = SearchState.initial;
      _searchResults = [];
      _searchError = null;
      notifyListeners();
      return;
    }

    _state = SearchState.searching;
    notifyListeners();

    // 마지막 입력 이후 일정 시간 후에 검색 수행 (과한 요청 방지)
    _debounceTimer = Timer(_debounceDuration, () {
      _performSearch(query);
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _query = '';
    _state = SearchState.initial;
    _searchResults = [];
    _searchError = null;
    notifyListeners();
  }

  Future<void> _performSearch(String query) async {
    try {
      _searchResults = await _repository.searchStocks(query);
      _searchError = null;

      if (_searchResults.isEmpty) {
        _state = SearchState.noResults;
      } else {
        _state = SearchState.results;
      }
    } catch (error) {
      _searchError = _mapError(error);
      _state = SearchState.initial;
    }
    notifyListeners();
  }

  Future<void> addToRecentlyViewed(String ticker, String name) async {
    final stock = RecentlyViewedStock(
      ticker: ticker,
      name: name,
      viewedAt: DateTime.now(),
    );
    await _repository.addRecentlyViewedStock(stock);
    _loadRecentlyViewed();
  }

  Future<void> retryPopularStocks() async {
    await _loadPopularStocks();
  }

  String _mapError(Object error) {
    debugPrint('SearchProvider Error: $error');
    if (error is DioException) {
      return error.message ?? '검색 중 오류가 발생했어요.';
    }
    return '검색 중 오류가 발생했어요.';
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
