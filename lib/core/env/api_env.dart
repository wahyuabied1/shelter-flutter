class ApiEnv {
  static const String dev = 'dev';
  static const String prod = 'prod';

  final Set<String> whitelistHost = {
    'amartha.id',
    'amartha.net',
    'amartha.com'
  };

  final String currentEnv;

  ApiEnv({
    required this.currentEnv,
  });

  String get shelter => env(
        key: 'aplusUrl',
        dev: 'api-aplus-dev.amartha.id/v1/api/',
        prod: 'api.amartha.net/v1/api/',
      );

  String env({
    required String key,
    required String dev,
    required String prod,
  }) {
    // Default value
    switch (currentEnv) {
      case ApiEnv.dev:
        return dev;
      case ApiEnv.prod:
        return prod;
      default:
        return dev;
    }
  }
}
