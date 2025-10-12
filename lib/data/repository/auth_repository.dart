import 'dart:async';

import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/network/auth_network.dart';

class AuthRepository {
  final CoreHttpRepository _coreHttpRepository;
  final AuthNetwork _authNetwork;

  AuthRepository(
    this._coreHttpRepository,
    this._authNetwork,
  );

  /// will not save null or empty [token], [sessionToken], [refreshToken]
  Future<void> saveSession({
    UserResponse? user,
  }) async {
    if (user?.token!= null && user!.token!.isNotEmpty) {
      await _coreHttpRepository.setUser(user);
    }
  }

  Future<UserResponse> getUser() async{
    return _coreHttpRepository.getUser();
  }

  Future<bool> isLoggedIn() =>
      _coreHttpRepository.getToken().then((token) => token.isNotEmpty);

  Future<JsonResponse<UserResponse>> login(
      {String username = '', String password = ''}) async {
    return await _authNetwork.login(username: username, password: password);
  }

  Future<JsonResponse<UserResponse>> refreshToken(
      {String username = '', String password = ''}) async {
    return await _authNetwork.refreshToken();
  }

  Future<ApiResponse> resetPasword(
      {String email = ''}) async {
    return await _authNetwork.resetPassword(email: email);
  }

  Future<void> logout({endSession = true}) async {
    await Future.delayed(Duration(seconds: 2));
    await Future.wait([
      _coreHttpRepository.clear(),
    ]);
  }
}
