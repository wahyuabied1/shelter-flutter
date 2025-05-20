import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/issuequ/home/issuequ_home.dart';
import 'package:shelter_super_app/feature/issuequ/keluhan/keluhan_screen.dart';
import 'package:shelter_super_app/feature/issuequ/mom/mom_screen.dart';

class IssueQuRoutes {
  IssueQuRoutes._();

  static final mainRoutes = [
    home,
    mom,
    keluhan
  ];

  static final home = GoRoute(
    path: '/issuequHome',
    name: 'IssueQu',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'IssueQuHome',
        child: const IssueQuHome(),
      );
    },
  );
  static final mom = GoRoute(
    path: '/mom',
    name: 'Mom',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'MoMScreen',
        child: const MomScreen(),
      );
    },
  );
  static final keluhan = GoRoute(
    path: '/keluhan',
    name: 'Keluhan',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'KeluhanScreen',
        child: const KeluhanScreen(),
      );
    },
  );
}