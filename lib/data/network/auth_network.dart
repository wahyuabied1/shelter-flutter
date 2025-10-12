import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/user_response.dart';

class AuthNetwork {
  static const _login = 'login';
  static const _refreshToken = 'refresh';
  static const _resetPassword = 'reset-password';
  final CoreHttpBuilder _http;

  AuthNetwork(this._http);

  Future<JsonResponse<UserResponse>> login({
    required String username,
    required String password,
  }) async {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    final response = await _http.shelterHttp(path: _login).post(map);
    return JsonResponse(response, UserResponse.fromJson);
  }

  Future<JsonResponse<UserResponse>> refreshToken() async {
    final response = await _http.shelterHttp(path: _refreshToken).post();
    return JsonResponse(response, UserResponse.fromJson);
  }

  Future<ApiResponse> resetPassword({required String email}) async {
    final map = <String, dynamic>{};
    map['email'] = email;
    final response = await _http.shelterHttp(path: _resetPassword).post(map);
    return ApiResponse(response);
  }
}