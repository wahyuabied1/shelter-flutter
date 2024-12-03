import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';

// Amartha Router Utility
class ARouter {
  GlobalKey<NavigatorState> get _navigatorKey => serviceLocator();

  final rootSheelNavigatorKey = GlobalKey<NavigatorState>();

  final routeObserver = ARouteObserver();

  /// Refresh current route
  void refresh() {
    final context = _navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).refresh();
    }
  }

  /// Get GoRouter instance without context
  /// Prefer use context.goNamed or context.pushNamed if you
  GoRouter? getRouter() {
    final context = _navigatorKey.currentContext;
    if (context != null) {
      return GoRouter.of(context);
    }
    return null;
  }

  /// Get [BuildContext] from currently shown route
  /// Usually you need to use this function to show modal
  /// inside redirect middleware
  BuildContext? currentRouteContext() =>
      routeObserver.currentRoute?.subtreeContext;

  /// Get current route [GoRouterState]
  /// Usually you need to use this to get current screen state inside a
  /// redirect middleware
  ///
  /// Will return null if currently shown screen not a GoRoute page
  /// (Maybe you use Navigator.of(context).push())
  GoRouterState? currentRouteState() {
    try {
      final context = routeObserver.currentRoute?.subtreeContext;
      if (context != null) {
        return GoRouterState.of(context);
      }

      return null;
    } on Error {
      return null;
    }
  }

  /// Since GoRouter redirection only return string
  /// We cannot passing extra(object) through it
  /// So we use this variable as simple tricky solution
  /// the getter function is consumable so it will only return once
  /// just to make sure no one forget to clear the variable after using it
  Object? _redirectionData;
  Object? get redirectionData {
    final data = _redirectionData;
    _redirectionData = null;
    return data;
  }

  set redirectionData(Object? data) {
    _redirectionData = data;
  }
}

/// Route observer for the GoRouter
/// It also listen to currently shown route and store it
class ARouteObserver extends RouteObserver<ModalRoute> {
  PageRoute? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      onPageChanged(route);
    }

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      onPageChanged(previousRoute);
    }

    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is PageRoute) {
      onPageChanged(newRoute);
    }

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      onPageChanged(previousRoute);
    }

    super.didRemove(route, previousRoute);
  }

  void onPageChanged(PageRoute route) {
    currentRoute = route;

    if (route is APageRoute) {
      route.goRouterState.then((value) {
        FirebaseCrashlytics.instance
            .log('Page Changed : ${value?.name ?? 'Unknown'}');
      });
    }
  }
}
