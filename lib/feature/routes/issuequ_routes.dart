import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/issue/detail_issue/detail_issue_screen.dart';
import 'package:shelter_super_app/feature/issue/home/issue_home.dart';
import 'package:shelter_super_app/feature/issue/new_issu/new_issue_screen.dart';
import 'package:shelter_super_app/feature/issuequ/home/issuequ_home.dart';
import 'package:shelter_super_app/feature/issuequ/keluhan/keluhan_screen.dart';
import 'package:shelter_super_app/feature/issuequ/mom/mom_screen.dart';

class IssueQuRoutes {
  IssueQuRoutes._();

  static final mainRoutes = [home, newIssue, detailIssue, mom, keluhan];

  // static final home = GoRoute(
  //   path: '/issuequHome',
  //   name: 'IssueQu',
  //   pageBuilder: (context, state) {
  //     return APage(
  //       key: state.pageKey,
  //       name: 'IssueQuHome',
  //       child: const IssueQuHome(),
  //     );
  //   },
  // );

  static final home = GoRoute(
    path: '/issue',
    name: 'Issue',
    pageBuilder: (context, state) {
      return APage(key: state.pageKey, child: const IssueHome());
    },
  );

  static final newIssue = GoRoute(
    path: '/new_issue',
    name: 'NewIssue',
    pageBuilder: (context, state) {
      return APage(key: state.pageKey, child: const NewIssueScreen());
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
  static final detailIssue = GoRoute(
    path: '/detail_issue',
    name: 'DetailIssue',
    pageBuilder: (context, state) {
      return APage(key: state.pageKey, child: const DetailIssueScreen());
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
