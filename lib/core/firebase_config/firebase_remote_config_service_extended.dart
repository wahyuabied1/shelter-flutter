import 'dart:async';

import 'package:hive/hive.dart';
import 'package:shelter_super_app/core/basic_extensions/object_extentions.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/firebase_config/firebase_remote_config_service.dart';

class FirebaseRemoteConfigServiceExtended extends FirebaseRemoteConfigService {
  late final LocalConfig _localConfig;
  final Future<HiveInterface> fHive = serviceLocator.getAsync<HiveInterface>();

  FirebaseRemoteConfigServiceExtended() : super();

  @override
  int getInt(String key) {
    _localConfig.updateLastUsed(key);
    return _localConfig.getValue(key)?.asInt() ?? super.getInt(key);
  }

  @override
  double getDouble(String key) {
    _localConfig.updateLastUsed(key);
    return _localConfig.getValue(key)?.asDouble() ?? super.getDouble(key);
  }

  @override
  String getString(String key) {
    _localConfig.updateLastUsed(key);
    return _localConfig.getValue(key)?.toString() ?? super.getString(key);
  }

  @override
  bool getBool(String key) {
    _localConfig.updateLastUsed(key);
    return _localConfig.getValue(key)?.asBool() ?? super.getBool(key);
  }

  @override
  Future<void> configure() async {
    await super.configure();
    final hive = await fHive;
    _localConfig = LocalConfig(await hive.openBox('LOCAL_REMOTE_CONFIG'));
  }

  Future<List<Map>> fetch(bool fromRemote) async {
    if (fromRemote) {
      /// Fetch keys from remote and save into local storage
      final keys = getKeyAll();
      for (final key in keys) {
        await _localConfig.setValue(key, null);
      }
    }
    return _localConfig.fetch();
  }

  String? getRemoteValue(String key) {
    return super.getString(key);
  }

  String? getLocalValue(String key) {
    return _localConfig.getValue(key)?.toString();
  }

  Future<void> remove(String key, {bool removeKey = false}) {
    if (removeKey) {
      return _localConfig.localStorage.delete(key);
    } else {
      return _localConfig.remove(key);
    }
  }

  Future<void> removeAll() {
    return _localConfig.removeAll();
  }

  Future<void> setValue(String key, dynamic value, [int? lastUsed]) {
    return _localConfig.setValue(key, value, lastUsed);
  }
}

class LocalConfig {
  late Box localStorage;

  LocalConfig(this.localStorage);

  Future<void> putOrUpdate(
    String key, {
    dynamic value,
    int? lastUsed,
    bool? remove,
  }) async {
    Map map = localStorage.get(key) ?? {};
    map['key'] = key;
    if (remove == true) {
      map.remove('value');
    } else {
      if (value != null) map['value'] = value;
      if (lastUsed != null) map['last_used'] = lastUsed;
    }
    await localStorage.put(key, map);
    return localStorage.flush();
  }

  Future<void> remove(key) {
    return putOrUpdate(key, remove: true);
  }

  Object? getValue(String key) {
    return localStorage.get(key)?['value'];
  }

  Future<void> setValue(String key, dynamic value, [int? lastUsed]) {
    return putOrUpdate(key, value: value, lastUsed: lastUsed);
  }

  Future<void> updateLastUsed(String key) {
    return putOrUpdate(key, lastUsed: DateTime.now().millisecondsSinceEpoch);
  }

  List<Map> fetch() {
    return localStorage.values.map((e) => e as Map).toList()
      ..sort((a, b) => (b['last_used'] ?? 0) - (a['last_used'] ?? 0));
  }

  Future<void> removeAll() async {
    final keys = localStorage.keys;
    for (var key in keys) {
      await remove(key);
    }
  }

  int size() {
    return localStorage.length;
  }
}
