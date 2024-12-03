import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:shelter_super_app/core/firebase_config/remote_config_key.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  String getString(String key) => _remoteConfig.getString(key);

  bool getBool(String key) => _remoteConfig.getBool(key);

  int getInt(String key) => _remoteConfig.getInt(key);

  double getDouble(String key) => _remoteConfig.getDouble(key);

  Future<void> _setConfigSettings() async =>
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));

  Future<void> _setDefaults() async => _remoteConfig.setDefaults(defaults);

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if (updated) {
      debugPrint('Firebase config updated');
    } else {
      debugPrint('Firebase config not updated');
    }
  }

  Future<void> initialize() async {
    await _setConfigSettings();
    await _setDefaults();
    await fetchAndActivate();
  }
}
