import 'package:flutter/foundation.dart';
import 'package:stock_talk/features/explore/domain/entities/news_entities.dart';
import 'package:stock_talk/features/explore/domain/repositories/explore_repository.dart';

class NewsDetailProvider extends ChangeNotifier {
  final ExploreRepository _repository;

  NewsDetailProvider(this._repository);

  NewsDetail? _newsDetail;
  NewsSummary? _newsSummary;
  bool _isLoadingDetail = false;
  bool _isLoadingSummary = false;
  String? _detailError;
  String? _summaryError;

  NewsDetail? get newsDetail => _newsDetail;
  NewsSummary? get newsSummary => _newsSummary;
  bool get isLoadingDetail => _isLoadingDetail;
  bool get isLoadingSummary => _isLoadingSummary;
  String? get detailError => _detailError;
  String? get summaryError => _summaryError;

  // 기사 상세 + AI 요약 동시 로드
  Future<void> loadNewsDetail(String url) async {
    _isLoadingDetail = true;
    _isLoadingSummary = true;
    _detailError = null;
    _summaryError = null;
    notifyListeners();

    _fetchDetail(url);
    _fetchSummary(url);
  }

  Future<void> _fetchDetail(String url) async {
    try {
      _newsDetail = await _repository.getNewsDetail(url);
      _isLoadingDetail = false;
      notifyListeners();
    } catch (e) {
      _detailError = '기사를 불러올 수 없습니다';
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<void> _fetchSummary(String url) async {
    try {
      _newsSummary = await _repository.getNewsSummary(url);
      _isLoadingSummary = false;
      notifyListeners();
    } catch (e) {
      _summaryError = 'AI 요약을 생성할 수 없습니다';
      _isLoadingSummary = false;
      notifyListeners();
    }
  }

  Future<void> retryDetail(String url, {bool showLoading = true}) =>
      loadNewsDetail(url);
}
