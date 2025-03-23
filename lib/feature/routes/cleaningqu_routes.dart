import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/cleaningqu/absence/absence_screen.dart';
import 'package:shelter_super_app/feature/cleaningqu/home/cleaningqu_home.dart';
import 'package:shelter_super_app/feature/cleaningqu/schedule_activity/schedule_activity_screen.dart';
import 'package:shelter_super_app/feature/cleaningqu/schedule_report/schedule_report_screen.dart';
import 'package:shelter_super_app/feature/cleaningqu/summary/summary_screen.dart';

class CleaningquRoutes {
  CleaningquRoutes._();

  static final mainRoutes = [
    home,
    scheduleReport,
    scheduleActivity,
    absence,
    summary
  ];

  static final home = GoRoute(
    path: '/cleaningquHome',
    name: 'CleaningQu',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'CleaningQuScreen',
        child: const CleaningQuHome(),
      );
    },
  );

  static final scheduleReport = GoRoute(
    path: '/scheduleReport',
    name: 'ScheduleReport',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ScheduleReportScreen',
        child: const ScheduleReportScreen(),
      );
    },
  );
  static final scheduleActivity = GoRoute(
    path: '/scheduleActivity',
    name: 'ScheduleActivity',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ScheduleActivityScreen',
        child: const ScheduleActivityScreen(),
      );
    },
  );
  static final absence = GoRoute(
    path: '/absence',
    name: 'Absence',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'AbsenceScreen',
        child: const AbsenceScreen(),
      );
    },
  );
  static final summary = GoRoute(
    path: '/summary',
    name: 'Summary',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'SummaryScreen',
        child: const SummaryScreen(),
      );
    },
  );
}
