class ApiEnv {
  static const String dev = 'dev';
  static const String prod = 'prod';

  final String currentEnv;

  ApiEnv({
    required this.currentEnv,
  });

  String get shelter => env(
        key: 'striveapp',
        dev: 'striveapp.id/api/v2/',
        prod: 'striveapp.id/api/v2/',
      );

  String get hadirqu => env(
        key: 'hadirku',
        dev: 'hadirku.co.id/open-api/',
        prod: 'hadirku.co.id/open-api/',
      );

  String get posko => env(
        key: 'posko',
        dev: 'posko.shelterapp.co.id/open-api/v1/',
        prod: 'posko.shelterapp.co.id/open-api/v1/',
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
