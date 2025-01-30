import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/hadirqu/employee/list_employee_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/home/hadirqu_home.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/report_dashboard_screen.dart';

class HadirQuRoutes {
  HadirQuRoutes._();

  static final mainRoutes = [
    home,
    listEmployee,
    reportDashboard,
    presence
  ];

  static final home = GoRoute(
    path: '/hadirquHome',
    name: 'HadirQu',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'HadirQuScreen',
        child: HadirQuHome(),
      );
    },
  );

  static final listEmployee = GoRoute(
    path: '/listEmployee',
    name: 'ListEmployee',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ListEmployeeScreen',
        child: ListEmployeeScreen(),
      );
    },
  );

  static final reportDashboard = GoRoute(
    path: '/reportDashboard',
    name: 'ReportDashboard',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ReportDashboardScreen',
        child: ReportDashboardScreen(),
      );
    },
  );

  static final presence = GoRoute(
    path: '/presence',
    name: 'Presence',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'PresenceScreen',
        child: PresenceScreen(),
      );
    },
  );

}
