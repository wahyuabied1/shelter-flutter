class CircuitBreakerException implements Exception {
  final String? message;

  CircuitBreakerException({
    this.message = 'Connection closed by circuit breaker',
  });

  @override
  String toString() {
    String result = 'CircuitBreakerException';
    if (message != null) result = '$result: $message';
    return result;
  }
}
