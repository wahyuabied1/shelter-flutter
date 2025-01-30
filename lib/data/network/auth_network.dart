import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/response/scalar_response.dart';

class AuthNetwork {
  static const _login = 'login';
  final CoreHttpBuilder _http;

  AuthNetwork(this._http);

  Future<ScalarResponse> login({
    required String username,
    required String password,
  }) async {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    final response = await _http.shelterHttp(path: _login).post(map);
    return ScalarResponse(response);
  }
}