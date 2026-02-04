class ApiConfig {
  const ApiConfig._();

  static const bool isProd = bool.fromEnvironment('PROD');

  static const String devBaseUrl = String.fromEnvironment(
    'API_DEV_BASE_URL',
    defaultValue: 'http://localhost:8000/api/v1',
  );

  static const String prodBaseUrl = String.fromEnvironment(
    'API_PROD_BASE_URL',
    defaultValue: 'http://13.124.149.125:8000/api/v1',
  );

  static const String baseUrl = isProd ? prodBaseUrl : devBaseUrl;

  static const String balancePath = '/trade/balance';
  static const String topMoversPath = '/market/top-movers';
  static const String popularNewsPath = '/news/popular';
  static const String newsDetailPath = '/news/detail';
  static const String newsSummaryPath = '/news/summarize';
  static const String stockDetailPath = '/market/stock';
  static const String stockNewsPath = '/news/stock';
  static const String searchPath = '/market/search';
  static const String chattingAskPath = '/chatting/ask';
  static const String chattingRoomsPath = '/chatting/rooms';
  static String chattingRoomMessagesPath(int roomId) =>
      '/chatting/rooms/$roomId/messages';
  static String chattingRoomDeletePath(int roomId) => '/chatting/rooms/$roomId';
}
