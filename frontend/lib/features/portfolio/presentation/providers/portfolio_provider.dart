import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_talk/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:stock_talk/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioProvider extends ChangeNotifier {
  PortfolioProvider(this._repository);

  final PortfolioRepository _repository;

  PortfolioBalance? _balance;
  bool _isLoading = false;
  String? _errorMessage;

  PortfolioBalance? get balance => _balance;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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

  String _mapError(Object error) {
    if (error is DioException) {
      return error.message ?? '데이터를 불러오지 못했어요.';
    }
    return '데이터를 불러오지 못했어요.';
  }
}
