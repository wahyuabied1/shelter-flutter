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
