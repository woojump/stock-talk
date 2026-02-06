import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/portfolio/domain/entities/order_history_entities.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioProvider extends ChangeNotifier {
  PortfolioProvider(this._repository);

  final PortfolioRepository _repository;

  PortfolioBalance? _balance;
  bool _isLoading = false;
  String? _errorMessage;

  OrderHistory? _orderHistory;
  bool _isLoadingOrders = false;
  String? _orderErrorMessage;
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  PortfolioBalance? get balance => _balance;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  OrderHistory? get orderHistory => _orderHistory;
  bool get isLoadingOrders => _isLoadingOrders;
  String? get orderErrorMessage => _orderErrorMessage;
  int get currentPage => _currentPage;
  int get totalPages => _orderHistory == null
      ? 0
      : (_orderHistory!.data.length / _itemsPerPage).ceil();

  List<OrderHistoryItem> get currentPageOrders {
    if (_orderHistory == null) return [];
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return _orderHistory!.data.sublist(
      startIndex,
      endIndex.clamp(0, _orderHistory!.data.length),
    );
  }

  Future<void> load({bool showLoading = true}) async {
    if (_isLoading) return;
    _isLoading = true;
    if (showLoading) {
      notifyListeners();
    }

    try {
      _balance = await _repository.fetchBalance();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = _mapError(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await load(showLoading: false);
  }

  Future<void> loadOrderHistory({bool showLoading = true}) async {
    if (_isLoadingOrders) return;
    _isLoadingOrders = true;
    if (showLoading) {
      notifyListeners();
    }

    try {
      _orderHistory = await _repository.fetchOrderHistory(qryTp: "1");
      _orderErrorMessage = null;
      _currentPage = 1; // 로드 시 첫 페이지로 초기화
    } catch (error) {
      _orderErrorMessage = _mapError(error);
    } finally {
      _isLoadingOrders = false;
      notifyListeners();
    }
  }

  void setPage(int page) {
    if (page < 1 || page > totalPages) return;
    _currentPage = page;
    notifyListeners();
  }

  String _mapError(Object error) {
    if (error is DioException) {
      return error.message ?? '데이터를 불러오지 못했어요.';
    }
    return '데이터를 불러오지 못했어요.';
  }
}
