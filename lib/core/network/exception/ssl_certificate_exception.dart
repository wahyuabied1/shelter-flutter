class SslCertificateException implements Exception {
  final String? message;

  SslCertificateException({this.message = 'SSL Certificate Error '});

  @override
  String toString() {
    String result = 'SslCertificateException';
    if (message != null) result = '$result: $message';
    return result;
  }
}
