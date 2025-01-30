import 'dart:io';

import 'package:alice/alice.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/event_bus/event_bus.dart';
import 'package:shelter_super_app/core/network/http/core_http_builder.dart';
import 'package:shelter_super_app/core/network/http/http_inspector.dart';
import 'package:shelter_super_app/core/network/interceptor/auth_interceptor.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/storage/core_secure_storage.dart';
import 'package:shelter_super_app/data/network/auth_network.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

// DI module where core dependencies is being put in one place
// If the module become huge, we need to split this into several DI modules
class CoreModule {
  GlobalKey<NavigatorState> navigatorKey() => GlobalKey();

  HttpInspector aliceHttpInspector() {
    return HttpInspector(
      Alice(
        navigatorKey: serviceLocator.get(),
        showNotification: false,
        showShareButton: true,
        showInspectorOnShake: false,
      ),
    );
  }

  Future<Map<String, String>> defaultHttpHeaders() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return Map.unmodifiable({
      'api-key': "TEST",
      'App-Version': packageInfo.buildNumber,
      'App-Name': 'shelterApp-flutter',
      'App-OS': Platform.operatingSystem,
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  EventBus eventBus() => EventBus();

  CoreHttpRepository coreHttpRepository(
    CoreSecureStorage coreSecureStorage
  ) {
    return CoreHttpRepository(coreSecureStorage);
  }

  CoreHttpBuilder coreHttpBuilder(
    Map<String, String> defaultHeaders,
    CoreHttpRepository coreHttpRepository,
    AuthInterceptor interceptor,
    {
    HttpInspector? inspector,
  }) {
    return CoreHttpBuilder(
      defaultHeaders: defaultHeaders,
      coreClient: () => InterceptedClient.build(
        interceptors: [
          interceptor,
          if (inspector != null) inspector,
        ],
      ),
      coreHttpRepository: coreHttpRepository,
    );
  }

  CoreSecureStorage coreSecureStorage() => CoreSecureStorage.defaultInstance;

  FirebaseMessaging firebaseMessaging() => FirebaseMessaging.instance;

  FirebaseInAppMessaging firebaseInAppMessaging() =>
      FirebaseInAppMessaging.instance;

  ARouter aRouter() => ARouter();

  static const _defaultHeaders = 'defaultHeaders';

  Future configureDependency() async {
    serviceLocator.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey());
    serviceLocator.registerSingleton<ARouter>(aRouter());
    serviceLocator.registerSingleton<CoreSecureStorage>(coreSecureStorage());
    serviceLocator.registerSingleton<EventBus>(eventBus());
    serviceLocator
        .registerSingleton<FirebaseInAppMessaging>(firebaseInAppMessaging());
    serviceLocator.registerSingleton<FirebaseMessaging>(firebaseMessaging());
    serviceLocator.registerSingleton<Map<String, String>>(
      await defaultHttpHeaders(),
      instanceName: _defaultHeaders,
    );
    if (kEnableDevOps) {
      serviceLocator.registerLazySingleton<HttpInspector>(
        () => aliceHttpInspector(),
      );
    }
    serviceLocator.registerFactory<CoreHttpRepository>(
      () => coreHttpRepository(
        serviceLocator<CoreSecureStorage>(),
      ),
    );
    serviceLocator.registerSingleton(AuthInterceptor());
    serviceLocator.registerFactory(
      () => coreHttpBuilder(
        serviceLocator(instanceName: _defaultHeaders),
        serviceLocator(),
        serviceLocator(),
        inspector: kEnableDevOps ? serviceLocator() : null,
      ),
    );

    serviceLocator.registerFactory<AuthNetwork>(
            () => AuthNetwork(serviceLocator<CoreHttpBuilder>()));

    serviceLocator.registerFactory<AuthRepository>(
          () => AuthRepository(
        serviceLocator<CoreHttpRepository>(),
        serviceLocator<AuthNetwork>()
      ),
    );
  }
}
