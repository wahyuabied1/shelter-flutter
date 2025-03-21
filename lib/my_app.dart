import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/event_bus/event_bus_listener.dart';
import 'package:shelter_super_app/core/event_bus/general_ui_event.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/ui_state/try_state_mixin.dart';
import 'package:shelter_super_app/feature/routes/main_routes.dart';
import 'package:shelter_super_app/feature/routes/page_not_found.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialRoute,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, TryStateMixin {
  late final GlobalKey<NavigatorState> navigatorKey = serviceLocator.get();

  late StreamSubscription _notifStream;
  late final ARouter aRouter = serviceLocator.get();
  late StreamSubscription _remoteConfigStreamSubscription;

  late final goRouter = GoRouter(
    initialLocation: widget.initialRoute,
    routes: [
      ShellRoute(
        observers: [
          aRouter.routeObserver,
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        navigatorKey: aRouter.rootSheelNavigatorKey,
        builder: (context, state, child) => child,
        routes: MainRoutes.routes,
      ),
    ],
    errorPageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        child: PageNotFound(),
      );
    },
    navigatorKey: navigatorKey,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _notifStream.cancel();
    _remoteConfigStreamSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void handleGeneralUIEvent(BuildContext context, dynamic event) {
    if (event is UIShowSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(event.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(360, 640),
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (ctx, child) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.grey,
          ),
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: goRouter,
            themeMode: ThemeMode.system,
            locale: const Locale('id', 'ID'),
            builder: (context, widget) {
              final child = EventBusListener(
                onEvent: (event) {
                  handleGeneralUIEvent(context, event);
                },
                child: kEnableDevOps
                    ? Stack(
                  children: [
                    widget!,
                  ],
                )
                    : widget!,
              );

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
