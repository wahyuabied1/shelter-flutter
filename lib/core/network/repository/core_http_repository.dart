import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/env/api_env.dart';
import 'package:shelter_super_app/core/firebase_config/firebase_remote_config_service.dart';
import 'package:shelter_super_app/core/platform/platform_information.dart';
import 'package:shelter_super_app/core/storage/core_secure_storage.dart';

class CoreHttpRepository {
  static const coreTokenIdKey = 'token_id';
  static const coreTokenKey = 'token';
  static const coreRefreshTokenKey = 'refresh_token';
  static const coreEnv = 'current_environment';

  final CoreSecureStorage secureStorage;
  final FirebaseRemoteConfigService remoteConfigService;

  CoreHttpRepository(this.secureStorage, this.remoteConfigService);

  Future<void> setToken(String token) =>
      secureStorage.setString(coreTokenKey, token);

  // can be empty
  Future<String> getToken() => secureStorage.getString(coreTokenKey);

  Future<void> setTokenId(String tokenId) =>
      secureStorage.setString(coreTokenIdKey, tokenId);

  Future<String> getTokenId() => secureStorage.getString(coreTokenIdKey);

  Future<void> setRefreshToken(String refreshToken) =>
      secureStorage.setString(coreRefreshTokenKey, refreshToken);

  Future<String> getRefreshToken() =>
      secureStorage.getString(coreRefreshTokenKey);

  Future<ApiEnv> getEnv() async {
    final currentEnv = await secureStorage.getString(coreEnv);
    final defaultEnv = await getDefaultEnv();
    if (currentEnv.isEmpty) {
      return ApiEnv(
        currentEnv: defaultEnv,
      );
    }

    return ApiEnv(
      currentEnv: currentEnv,
    );
  }

  Future setEnv(String env) => secureStorage.setString(coreEnv, env);

  Future<String> getDefaultEnv() async {
    String flavor = await PlatformInformation.getFlavor();
    if (flavor == isDev) {
      return ApiEnv.dev;
    }
    return ApiEnv.prod;
  }

  List<String> allEnvs() => [ApiEnv.dev, ApiEnv.prod];

  Future<void> clear() async {
    await secureStorage.deleteData(coreTokenKey);
    await secureStorage.deleteData(coreEnv);
    await secureStorage.deleteData(coreTokenIdKey);
  }

  Future clearRefreshToken() async {
    await secureStorage.deleteData(coreRefreshTokenKey);
  }
}
