import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PlatformInformation {
  static const MethodChannel _channel =
      MethodChannel('com.shelter.indonesia.superapps/platformInfo');

  static Future<bool> isVirtualMachine() async {
    try {
      final bool result = await _channel.invokeMethod('isEmulator');
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  static Future<bool> isDebuggerConnected() async {
    if (const bool.fromEnvironment('dart.vm.isolate_run_in_debugger')) {
      return true;
    }

    try {
      final bool result = await _channel.invokeMethod('isDebuggerConnected');
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  static Future<bool> isDeviceRooted() async {
    try {
      final bool result = await _channel.invokeMethod('isDeviceRooted');
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Sample return: 31
  static Future<int> get androidSdkInt async {
    assert(Platform.isAndroid);
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }

  /// Sample return: '17.0.1'
  static Future<String> get iosVersion async {
    assert(Platform.isIOS);
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    return iosInfo.systemVersion;
  }

  // Sample return: 'dev' || 'uat || 'prod
  static Future<String> getFlavor() async {
    try {
      final String result = await _channel.invokeMethod('getFlavor');
      return result;
    } on PlatformException catch (_) {
      return 'dev';
    }
  }

  static Future<String> getAppVersion() async {
    try {
      final result = await PackageInfo.fromPlatform();
      return result.version;
    } on PlatformException catch (_) {
      return '0.0.0';
    }
  }

  /// https://developer.android.com/training/articles/app-set-id
  static Future<String> getSetAppId() async {
    try {
      final String result = await _channel.invokeMethod('getSetAppId');
      return result;
    } on PlatformException catch (_) {
      return '';
    }
  }

  /// check whether Developer Mode is turned on in Android.
  /// on iOS, this always return false
  static Future<bool> isDeveloperMode() async {
    if (Platform.isAndroid) {
      try {
        final bool result = await _channel.invokeMethod('isDeveloperMode');
        return result;
      } on PlatformException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<String> getAndroidId() async {
    try {
      final String result = await _channel.invokeMethod('getAndroidId');
      return result;
    } on PlatformException catch (_) {
      return '';
    }
  }
}
