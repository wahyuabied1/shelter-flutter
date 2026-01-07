import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shelter_super_app/app/di/core_di_module.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/env/api_env.dart';
import 'package:shelter_super_app/core/platform/platform_information.dart';
import 'package:shelter_super_app/core/storage/core_secure_storage.dart';
import 'package:shelter_super_app/data/model/user_response.dart';

class CoreHttpRepository {
  static const coreTokenKey = 'token';
  static const userKey = 'user';
  static const coreEnv = 'current_environment';
  static const sha = 'sha';

  final CoreSecureStorage secureStorage;

  CoreHttpRepository(this.secureStorage);

  String sha256Encrypt({
    required String token,
    required String apiKey,
    required String secretKey,
  }) {
    final message = token + apiKey;
    final hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
    final digest = hmacSha256.convert(utf8.encode(message));
    return digest.toString(); // hex string
  }

  Future<void> setToken(String token) {
    String encryptedSha = sha256Encrypt(token: token, apiKey: CoreModule.apikey, secretKey: CoreModule.secretKey);
    secureStorage.setString(sha, encryptedSha);
    return secureStorage.setString(coreTokenKey, token);
  }

  Future<void> setUser(UserResponse user)async {
    setToken(user.token ?? "");
    await secureStorage.setString(userKey, UserResponse.serialize(user));
  }

  Future<UserResponse> getUser() async{
    var json = await secureStorage.getString(userKey);
    return UserResponse.deserialize(json);
  }

  // can be empty
  Future<String> getToken() async =>  await secureStorage.getString(coreTokenKey);

  Future<String> getSHA() async =>  await secureStorage.getString(sha);

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
    await secureStorage.deleteData(userKey);
    await secureStorage.deleteData(coreEnv);
  }

}
