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
}
