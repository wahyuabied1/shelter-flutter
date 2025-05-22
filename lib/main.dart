import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/app/di/core_di.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/firebase_config/firebase_remote_config_service_extended.dart';
import 'package:shelter_super_app/core/utils/common.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';
import 'package:shelter_super_app/feature/profile/view_model/shared_user_model.dart';
import 'package:shelter_super_app/feature/routes/homepage_routes.dart';
import 'package:shelter_super_app/feature/splash_screen.dart';
import 'package:shelter_super_app/my_app.dart';
import 'package:upgrader/upgrader.dart';
import 'core/firebase_config/firebase_remote_config_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Completer<int> initializationStatus = Completer();

Future<void> main() async {
  runApp(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: false),
      home: SplashScreen(
        initializationStatus: initializationStatus,
      ),
    ),
  );

  await _initialization();

  /// Finding initial route based on login status
  final String initialRoute = await _findInitialRoute();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SharedUserModel()..initialize(),
          lazy: true,
        ),
      ],
      child: MyApp(
        initialRoute: initialRoute,
      ),
    ),
  );
}

Future<String> _findInitialRoute() async {
  final isLoggedIn = await serviceLocator<AuthRepository>().isLoggedIn();
  if (isLoggedIn) {
    return HomepageRoutes.main.path;
  }
  return HomepageRoutes.login.path;
}

Future<bool> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  //potrait screen
  unawaited(SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]));

  //localStorage
  _initHiveAsync();

  //firebase
  await retry(3, () => Firebase.initializeApp());
  await _configureFirebaseRemoteConfig();
  await configureCoreDependencies();
  FirebaseMessaging firebaseMessaging() => FirebaseMessaging.instance;
  FirebaseInAppMessaging firebaseInAppMessaging() =>
      FirebaseInAppMessaging.instance;
  serviceLocator
      .registerSingleton<FirebaseInAppMessaging>(firebaseInAppMessaging());
  serviceLocator.registerSingleton<FirebaseMessaging>(firebaseMessaging());

  //dependencies
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }
  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  return true;
}

void _initHiveAsync() {
  serviceLocator.registerSingletonAsync<HiveInterface>(() async {
    await Hive.initFlutter();
    return Hive;
  });
}

Future<void> _configureFirebaseRemoteConfig() async {
  await withTracer(
    () async {
      final remoteConfig = kEnableDevOps
          ? FirebaseRemoteConfigServiceExtended()
          : FirebaseRemoteConfigService();
      await remoteConfig.configure();
      serviceLocator
          .registerSingleton<FirebaseRemoteConfigService>(remoteConfig);
    },
    traceName: 'init-firebase-remote-config',
    library: 'FirebaseRemoteConfig',
    errorContext: 'while configuring remoteConfig',
  );
}

Future<T?> withTracer<T>(
  Future<T> Function() task, {
  required String traceName,
  required String library,
  required String errorContext,
}) async {
  Trace? trace;

  try {
    trace = FirebasePerformance.instance.newTrace(traceName);
    await trace.start();
    final result = await task();
    return result;
  } catch (error, stack) {
    FlutterErrorDetails details = FlutterErrorDetails(
      exception: error,
      stack: stack,
      library: library,
      context: ErrorDescription(errorContext),
    );

    unawaited(FirebaseCrashlytics.instance.recordFlutterError(details));
    return null;
  } finally {
    await trace?.stop();
  }
}

Future<T> _runWithDuration<T>({
  required Future<T> future,
  required int millisecond,
}) async {
  final startTime = DateTime.now();
  final result = await future;
  final completedTime = DateTime.now();
  final duration = completedTime.difference(startTime);
  if (duration.inMilliseconds < millisecond) {
    await Future.delayed(Duration(
      milliseconds: millisecond - duration.inMilliseconds,
    ));
  }
  return result;
}
