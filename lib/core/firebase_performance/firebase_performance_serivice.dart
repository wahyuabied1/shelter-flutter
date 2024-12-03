import 'package:firebase_performance/firebase_performance.dart';

class FirebasePerformanceService {
  FirebasePerformanceService._() : _performance = FirebasePerformance.instance;

  static FirebasePerformanceService? _instance;
  factory FirebasePerformanceService() =>
      _instance ??= FirebasePerformanceService._();

  final FirebasePerformance _performance;
  late Trace _trace;

  Future<void> startTrace(String traceName) async {
    _trace = _performance.newTrace(traceName);
    await _trace.start();
  }

  Future<void> stopTrace() async {
    await _trace.stop();
  }

  void setTraceMetric(String metricName, int metric) {
    _trace.setMetric(metricName, metric);
  }

  void putTraceAttribute(String attributeName, String value) {
    _trace.putAttribute(attributeName, value);
  }
}
