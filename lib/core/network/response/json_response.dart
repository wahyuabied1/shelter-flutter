import 'package:flutter/foundation.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/network/response/type_defs.dart';

/// Response of [data] with type [Json].
/// constructor [cast] to cast [Json] -> [T].
/// returns [Null] if failed to cast
class JsonResponse<T> extends ApiResponse {
  /// function to convert body to JSON
  final T Function(Json json) cast;
  final Json Function()? source;
  late final T? data = castJson();

  JsonResponse(super.response, this.cast, {this.source});

  T? castJson() {
    try {
      return cast(source?.call() ?? rawData);
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: s);
      }
      return null;
    }
  }
}
