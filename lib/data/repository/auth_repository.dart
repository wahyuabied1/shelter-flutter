import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shelter_super_app/core/firebase_config/firebase_remote_config_service.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/storage/core_secure_storage.dart';

class AuthRepository {
  final CoreSecureStorage _secureStorage;
  final CoreHttpRepository _coreHttpRepository;
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseRemoteConfigService _remoteConfig;

  AuthRepository(
    this._secureStorage,
    this._coreHttpRepository,
    this._firebaseMessaging,
    this._remoteConfig,
  );

  /// will not save null or empty [token], [sessionToken], [refreshToken]
  Future<void> saveSession({
    String? tokenId,
    String? token,
    String? refreshToken,
    String? sessionToken,
  }) async {
    if (tokenId != null && tokenId.isNotEmpty) {
      await _coreHttpRepository.setTokenId(tokenId);
    }
    if (token != null && token.isNotEmpty) {
      await _coreHttpRepository.setToken(token);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _coreHttpRepository.setRefreshToken(refreshToken);
    }
  }

  Future<bool> isLoggedIn() =>
      _coreHttpRepository.getToken().then((token) => token.isNotEmpty);

  Future<void> logout({endSession = true}) async {
    await Future.wait([
      _coreHttpRepository.clear(),
    ]);
  }
}
