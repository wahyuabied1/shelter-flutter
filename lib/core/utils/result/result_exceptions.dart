import 'package:shelter_super_app/core/network/response/api_response.dart';

class ApiResultException implements Exception {
  final dynamic message;
  final ApiResponse response;
  final Object? additionalInfo;

  ApiResultException(
    this.message,
    this.response, {
    this.additionalInfo,
  });

  @override
  String toString() {
    return message ?? '';
  }
}
