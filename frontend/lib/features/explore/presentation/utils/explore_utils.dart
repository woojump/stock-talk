import 'package:intl/intl.dart';

String formatNewsPublishDate(String pubDate) {
  try {
    // "Mon, 01 Jan 2024 12:00:00 +0900" 형식 파싱
    final date = DateFormat(
      'EEE, dd MMM yyyy HH:mm:ss Z',
      'en_US',
    ).parse(pubDate);
    return DateFormat('yyyy년 MM월 dd일 HH:mm', 'ko_KR').format(date);
  } catch (e) {
    return pubDate;
  }
}
