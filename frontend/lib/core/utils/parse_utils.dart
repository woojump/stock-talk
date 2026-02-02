/// API 응답의 동적 타입을 안전하게 파싱하는 유틸리티
class ParseUtils {
  /// dynamic 값을 double로 변환
  ///
  /// - double: 그대로 반환
  /// - int: double로 변환
  /// - String: 파싱 시도, 실패 시 0.0
  /// - 그 외: 0.0
  static double parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// dynamic 값을 int로 변환
  ///
  /// - int: 그대로 반환
  /// - double: int로 변환
  /// - String: 파싱 시도, 실패 시 0
  /// - 그 외: 0
  static int parseInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  /// String을 DateTime으로 변환
  ///
  /// "YYYYMMDD" 형식 (예: "20240101") 또는 ISO 8601 형식 지원
  /// 파싱 실패 시 현재 시간 반환
  static DateTime parseDateTime(String value) {
    // Handle "YYYYMMDD" format
    if (value.length == 8 && !value.contains('-')) {
      try {
        final year = int.parse(value.substring(0, 4));
        final month = int.parse(value.substring(4, 6));
        final day = int.parse(value.substring(6, 8));
        return DateTime(year, month, day);
      } catch (e) {
        return DateTime.now();
      }
    }
    // Fallback to standard ISO 8601 parsing
    return DateTime.tryParse(value) ?? DateTime.now();
  }
}
