import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RouterExt on BuildContext {
  /// Pop all widget that pushed using imperative API [Navigator.push]
  /// Until go router page is found
  void popAllImperative({
    bool rootNavigator = false,
  }) {
    Navigator.of(this, rootNavigator: rootNavigator)
        .popUntil((route) => route.settings is Page);
  }

  /// Pop all go router page until the route path is found
  void popUntilPath(String routePath, {bool inclusive = false}) {
    final go = GoRouter.of(this);
    List routeStacks = [...go.routerDelegate.currentConfiguration.routes];

    for (int i = routeStacks.length - 1; i >= 0; i--) {
      RouteBase route = routeStacks[i];
      if (route is GoRoute) {
        if (!inclusive && route.path == routePath) break;
        if (i != 0 && routeStacks[i - 1] is ShellRoute) {
          RouteMatchList matchList = go.routerDelegate.currentConfiguration;
          go.restore(matchList.remove(matchList.matches.last));
        } else {
          go.pop();
        }
        if (inclusive && route.path == routePath) break;
      }
    }
  }
}
