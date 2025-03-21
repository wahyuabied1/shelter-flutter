import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/home/home_screen.dart';
import 'package:shelter_super_app/feature/login/login_screen.dart';
import 'package:shelter_super_app/feature/password/reset_password_screen.dart';

class HomepageRoutes {
  HomepageRoutes._();

  static final mainRoutes = [
    main,
    login,
    resetPass,
    appMain,
  ];

  static final homeChildRoutes = <GoRoute>[
    // Add routes that need to opened after home is shown
  ];

  static final main = GoRoute(
    path: '/',
    name: 'Homepage',
    routes: homeChildRoutes,
    pageBuilder: (context, state) {
      final queryParams = state.uri.queryParameters;
      final page = int.tryParse(queryParams['page'] ?? '') ?? 0;
      final showAlreadyLogin = queryParams['showAlreadyLogin'] == 'true';

      return APage(
        key: state.pageKey,
        name: 'Homepage',
        child: HomeScreen(
          selectedPage: page,
          showAlreadyLogin: showAlreadyLogin,
        ),
      );
    },
  );

  static final resetPass = GoRoute(
    path: '/resetPassword',
    name: 'ResetPasswordScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ResetPasswordScreen',
        child: const ResetPasswordScreen(),
      );
    },
  );

  static final login = GoRoute(
    path: '/login',
    name: 'LoginScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'LoginScreen',
        child: const LoginScreen(),
      );
    },
  );

  /// This route is backward compatible support for legacy kotlin apps.
  /// pass parameters to route direction (path: '/')
  static final appMain = GoRoute(
    path: '/app/home',
    name: 'App Homepage',
    redirect: (context, state) async => '/?${state.uri.query}',
  );
}
