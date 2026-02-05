import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_talk/features/explore/data/dto/recently_viewed_stock_dto.dart';

class SearchLocalDataSource {
  static const String _recentlyViewedKey = 'recently_viewed_stocks';
  static const int _maxRecentItems = 10;

  final SharedPreferences _prefs;

  SearchLocalDataSource(this._prefs);

  List<RecentlyViewedStockDto> getRecentlyViewedStocks() {
    try {
      final jsonString = _prefs.getString(_recentlyViewedKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map(
            (json) =>
                RecentlyViewedStockDto.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      // JSON 파싱 실패 시 빈 리스트 반환
      return [];
    }
  }

  Future<void> addRecentlyViewedStock(RecentlyViewedStockDto dto) async {
    final stocks = getRecentlyViewedStocks();

    // 이미 존재하는 경우 제거
    stocks.removeWhere((s) => s.ticker == dto.ticker);

    // 맨 앞에 추가
    stocks.insert(0, dto);

    // 최대 개수 유지
    final trimmedStocks = stocks.take(_maxRecentItems).toList();

    final jsonString = json.encode(
      trimmedStocks.map((s) => s.toJson()).toList(),
    );
    await _prefs.setString(_recentlyViewedKey, jsonString);
  }
}
