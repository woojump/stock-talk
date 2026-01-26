class ApiConfig {
  const ApiConfig._();

  static const bool isProd = bool.fromEnvironment('PROD');

  static const String devBaseUrl = String.fromEnvironment(
    'API_DEV_BASE_URL',
    defaultValue: 'http://localhost:8000/api/v1',
  );

  static const String prodBaseUrl = String.fromEnvironment(
    'API_PROD_BASE_URL',
    defaultValue: 'https://api.example.com/api/v1', // AWS EC2 주소로 변경 예정
  );

  static const String baseUrl = isProd ? prodBaseUrl : devBaseUrl;

  static const String balancePath = '/trade/balance';
}
