import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shelter_super_app/core/firebase_config/remote_config_key.dart';
import 'package:shelter_super_app/core/utils/common.dart';

/// A singleton service class for Firebase Remote Config.
///
/// This class is responsible for:
/// - Fetching and activating Firebase Remote Config
/// - Providing the values from the config
/// - Providing a stream to listen to the config update
/// - Providing a method to configure the Firebase Remote Config
///
/// Methods:
/// - [configure]: Configures the Firebase Remote Config
/// - [fetchAndActivate]: Fetches and activates the Firebase Remote Config
/// - [onConfigUpdated]: Listens to the config update
/// - [getString], [getBool], [getInt], [getDouble]: Gets the values
///   from the config
/// - [getKeyAll]: Gets all the keys from the config
/// - [lastFetchTime]: Gets the last fetch time
/// - [lastFetchStatus]: Gets the last fetch status
/// - [appId]: Gets the app id
/// - [appInfo]: Gets the app info
class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService() : _remoteConfig = FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  late final Stream<RemoteConfigUpdate> onConfigUpdated =
  _remoteConfig.onConfigUpdated.asyncMap((remoteConfigUpdate) async {
    await _remoteConfig.activate();
    return remoteConfigUpdate;
  }).handleError((err, stack) {
    final errorDetails = FlutterErrorDetails(
      exception: err,
      stack: stack,
      library: 'FirebaseRemoteConfig',
      context: ErrorDescription('while listening to onConfigUpdated'),
    );

    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  });

  /// Configure Firebase Remote Config
  Future<void> configure() async {
    await _setConfigSettings();
    await _setDefaults();

    try {
      await retry(3, fetchAndActivate);
    } catch (error, stack) {
      FlutterErrorDetails details = FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'FirebaseRemoteConfig',
        context: ErrorDescription('while fetchAndActivate RemoteConfig'),
      );
      unawaited(FirebaseCrashlytics.instance.recordFlutterError(details));
    }
  }

  /// Throws exception on network error!
  Future<bool> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();
    if (updated) {
      debugPrint('Firebase config updated');
    } else {
      debugPrint('Firebase config not updated');
    }
    return updated;
  }

  /// Returns '' if the key does not exist.
  /// consider using [streamString] for real time updates
  String getString(String key) => _remoteConfig.getString(key);

  /// Returns false if the key does not exist.
  /// consider using [streamBool] for real time updates
  bool getBool(String key) => _remoteConfig.getBool(key);

  /// Returns 0 if the key does not exist.
  /// consider using [streamInt] for real time updates
  int getInt(String key) => _remoteConfig.getInt(key);

  /// Returns 0 if the key does not exist.
  /// consider using [streamDouble] for real time updates
  double getDouble(String key) => _remoteConfig.getDouble(key);

  /// Stream emits current config value and updates when the key is updated.
  /// a listener is guaranteed to receive the latest value when subscribed.
  Stream<bool> streamBool(String key) {
    return BehaviorSubject<bool>()
      ..add(getBool(key))
      ..addStream(
        onConfigUpdated
            .where((event) => event.updatedKeys.contains(key))
            .map((event) => getBool(key)),
      );
  }

  /// Stream emits current config value and updates when the key is updated.
  /// a listener is guaranteed to receive the latest value when subscribed.
  Stream<String> streamString(String key) {
    return BehaviorSubject<String>()
      ..add(getString(key))
      ..addStream(
        onConfigUpdated
            .where((event) => event.updatedKeys.contains(key))
            .map((event) => getString(key)),
      );
  }

  /// Stream emits current config value and updates when the key is updated.
  /// a listener is guaranteed to receive the latest value when subscribed.
  Stream<int> streamInt(String key) {
    return BehaviorSubject<int>()
      ..add(getInt(key))
      ..addStream(
        onConfigUpdated
            .where((event) => event.updatedKeys.contains(key))
            .map((event) => getInt(key)),
      );
  }

  /// Stream emits current config value and updates when the key is updated.
  /// a listener is guaranteed to receive the latest value when subscribed.
  Stream<double> streamDouble(String key) {
    return BehaviorSubject<double>()
      ..add(getDouble(key))
      ..addStream(
        onConfigUpdated
            .where((event) => event.updatedKeys.contains(key))
            .map((event) => getDouble(key)),
      );
  }

  List<String> getKeyAll() {
    return _remoteConfig.getAll().keys.toList();
  }

  DateTime lastFetchTime() => _remoteConfig.lastFetchTime;

  String lastFetchStatus() => _remoteConfig.lastFetchStatus.name;

  String appId() => _remoteConfig.app.options.appId;

  List<MapEntry<String, String?>> appInfo() =>
      _remoteConfig.app.options.asMap.entries
          .where((element) => element.value != null)
          .toList();

  Future<void> _setConfigSettings() {
    return _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 12),
    ));
  }

  Future<void> _setDefaults() => _remoteConfig.setDefaults(defaults);
}
