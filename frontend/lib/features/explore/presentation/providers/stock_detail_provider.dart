import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/entities/stock_detail_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/stock_detail_repository.dart';

class StockDetailProvider extends ChangeNotifier {
  StockDetailProvider(this._repository);

  final StockDetailRepository _repository;

  StockDetail? _stockDetail;
  List<NewsItem>? _stockNews;
  bool _detailLoading = false;
  bool _newsLoading = false;
  String? _detailError;
  String? _newsError;
  ChartPeriod _selectedPeriod = ChartPeriod.day;

  StockDetail? get stockDetail => _stockDetail;
  List<NewsItem>? get stockNews => _stockNews;
  bool get detailLoading => _detailLoading;
  bool get newsLoading => _newsLoading;
  String? get detailError => _detailError;
  String? get newsError => _newsError;
  ChartPeriod get selectedPeriod => _selectedPeriod;

  bool get isLoading => _detailLoading || _newsLoading;

  String? get errorMessage => _detailError ?? _newsError;

  /// 기간 탭 선택
  void selectPeriod(ChartPeriod period) {
    // 현재는 '일' 탭만 활성화 (백엔드에서 이것만 지원)
    if (period != ChartPeriod.day) return;

    _selectedPeriod = period;
    notifyListeners();
  }

  Future<void> _loadStockDetail(
    String ticker, {
    bool showLoading = true,
  }) async {
    if (_detailLoading) return;

    if (showLoading) {
      _detailLoading = true;
      notifyListeners();
    }

    try {
      _stockDetail = await _repository.getStockDetail(ticker);
      _detailError = null;
    } catch (error) {
      _detailError = _mapError(error);
    } finally {
      _detailLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadStockNews(
    String stockName, {
    bool showLoading = true,
  }) async {
    if (_newsLoading) return;

    if (showLoading) {
      _newsLoading = true;
      notifyListeners();
    }

    try {
      _stockNews = await _repository.getStockNews(stockName);
      _newsError = null;
    } catch (error) {
      _newsError = _mapError(error);
    } finally {
      _newsLoading = false;
      notifyListeners();
    }
  }

  Future<void> load(
    String ticker,
    String stockName, {
    bool showLoading = true,
  }) async {
    await Future.wait([
      _loadStockDetail(ticker, showLoading: showLoading),
      _loadStockNews(stockName, showLoading: showLoading),
    ]);
  }

  Future<void> refresh(String ticker, String stockName) async {
    await load(ticker, stockName, showLoading: false);
  }

  Future<void> retryStockDetail(String ticker) async {
    await _loadStockDetail(ticker);
  }

  Future<void> retryStockNews(String stockName) async {
    await _loadStockNews(stockName);
  }

  String _mapError(Object error) {
    debugPrint('StockDetailProvider Error: $error');
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
