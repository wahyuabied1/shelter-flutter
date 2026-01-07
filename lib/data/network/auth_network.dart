import 'dart:ui';

import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/change_password_response.dart';
import 'package:shelter_super_app/data/model/user_response.dart';

class AuthNetwork {
  static const _login = 'login';
  static const _refreshToken = 'refresh';
  static const _resetPassword = 'reset-password';
  static const _logout = 'logout';
  static const _changePassword = 'profile/password';
  static const _changeProfile = 'profile/update';
  static const _changeAvatar = 'profile/avatar';
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

  Future<ApiResponse> logout() async {
    final response = await _http.shelterHttp(path: _logout).post();
    return ApiResponse(response);
  }

  Future<JsonResponse<ChangePasswordReponse>> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    final map = <String, dynamic>{};
    map['old_password'] = oldPassword;
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    map['_method'] = 'PUT';
    final response = await _http.shelterHttp(path: _changePassword).post(map);

    return JsonResponse(response, ChangePasswordReponse.fromJson);
  }

  Future<JsonResponse<User>> changeProfile({
    required User user,
  }) async {
    final map = <String, dynamic>{};
    map['nama'] = user.nama;
    map['username'] = user.username;
    map['email'] = user.email;
    map['alamat'] = user.alamat;
    map['_method'] = 'PATCH';
    final response = await _http.shelterHttp(path: _changeProfile).post(map);

    return JsonResponse(response, User.fromJson);
  }

  Future<JsonResponse<User>> changeAvatar({
    required Image image,
  }) async {
    final map = <String, dynamic>{};
    map['foto'] = image;
    map['_method'] = 'PUT';
    final response = await _http.shelterHttp(path: _changeAvatar).post(map);

    return JsonResponse(response, User.fromJson);
  }
}
