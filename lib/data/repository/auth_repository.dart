import 'dart:async';

import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/scalar_response.dart';
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

  Future<bool> isLoggedIn() =>
      _coreHttpRepository.getToken().then((token) => token.isNotEmpty);

  Future<ScalarResponse> login(
      {String username = '', String password = ''}) async {
    return await _authNetwork.login(username: username, password: password);
  }

  Future<void> logout({endSession = true}) async {
    await Future.wait([
      _coreHttpRepository.clear(),
    ]);
  }
}
