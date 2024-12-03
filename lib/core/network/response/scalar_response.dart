import 'package:shelter_super_app/core/network/response/api_response.dart';

/// Response of [data] with built-in types: [String],[int],[double],[bool]
/// and [List] of primitives.
/// this class does not support any complex casting.
/// throw [FormatException] when expected type is different than actual.
class ScalarResponse<T> extends ApiResponse {
  late final T? data = cast();

  ScalarResponse(super.response);

  T? cast() {
    final dynamic value = rawData;
    if (value == null) return null;
    if (value is T) return value;

    throw FormatException(
      'expected T: $T but actual data: ${value.runtimeType}',
      value,
    );
  }
}
