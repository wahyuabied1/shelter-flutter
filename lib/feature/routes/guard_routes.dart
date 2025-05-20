import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/guard/daily_journal/daily_journal_screen.dart';
import 'package:shelter_super_app/feature/guard/guest/guest_screen.dart';
import 'package:shelter_super_app/feature/guard/home/guard_home.dart';
import 'package:shelter_super_app/feature/guard/kendaraan_operasional/kendaraan_operasional_screen.dart';
import 'package:shelter_super_app/feature/guard/mail/mail_screen.dart';
import 'package:shelter_super_app/feature/guard/news/news_screen.dart';
import 'package:shelter_super_app/feature/guard/pemakaian_telp/pemakaian_telp_screen.dart';
import 'package:shelter_super_app/feature/guard/pinjaman_kunci/pinjaman_kunci_screen.dart';
import 'package:shelter_super_app/feature/guard/project/project_screen.dart';
import 'package:shelter_super_app/feature/guard/transporter/transporter_screen.dart';

class GuardRoutes {
  GuardRoutes._();

  static final mainRoutes = [
    home,
    pinjamanKunci,
    pemakaianTelp,
    kendaraan,
    guest,
    project,
    transporter,
    dailyJournal,
    mail,
    news
  ];

  static final home = GoRoute(
    path: '/guardHome',
    name: 'Guard',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'GuardScreen',
        child: const GuardHome(),
      );
    },
  );

  static final pinjamanKunci = GoRoute(
    path: '/pinjamanKunci',
    name: 'Pinjaman Kunci',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'PinjamanKunciScreen',
        child: const PinjamanKunciScreen(),
      );
    },
  );

  static final pemakaianTelp = GoRoute(
    path: '/pemakaianTelp',
    name: 'Pemakaian Telpon',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'PemakaianTelpScreen',
        child: const PemakaianTelpScreen(),
      );
    },
  );

  static final kendaraan = GoRoute(
    path: '/kendaraan',
    name: 'Kendaraan Operasional',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'KendaraanOperasionalScreen',
        child: const KendaraanOperasionalScreen(),
      );
    },
  );

  static final guest = GoRoute(
    path: '/guest',
    name: 'Guest',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'GuestScreen',
        child: const GuestScreen(),
      );
    },
  );

  static final project = GoRoute(
    path: '/project',
    name: 'Project',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'ProjectScreen',
        child: const ProjectScreen(),
      );
    },
  );
  static final transporter = GoRoute(
    path: '/transporter',
    name: 'transporterScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'TransporterScreen',
        child: const TransporterScreen(),
      );
    },
  );
  static final dailyJournal = GoRoute(
    path: '/dailyJournal',
    name: 'dailyJournalScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'DailyJournalScreen',
        child: const DailyJournalScreen(),
      );
    },
  );

  static final mail = GoRoute(
    path: '/mail',
    name: 'mailScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'MailScreen',
        child: const MailScreen(),
      );
    },
  );
  static final news = GoRoute(
    path: '/news',
    name: 'newsScreen',
    pageBuilder: (context, state) {
      return APage(
        key: state.pageKey,
        name: 'NewsScreen',
        child: const NewsScreen(),
      );
    },
  );
}