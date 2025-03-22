import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/cleaningqu/home/cleaningqu_home.dart';
import 'package:shelter_super_app/feature/hadirqu/home/hadirqu_home.dart';

class CleaningquRoutes {
  CleaningquRoutes._();

  static final mainRoutes = [
    home,
  ];

  static final home = GoRoute(
    path: '/cleaningquHome',
    name: 'CleaningQu',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'CleaningQuScreen',
        child: CleaningQuHome(),
      );
    },
  );
}
