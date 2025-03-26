import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/routing/core/a_page.dart';
import 'package:shelter_super_app/feature/guard/guest/guest_screen.dart';
import 'package:shelter_super_app/feature/guard/home/guard_home.dart';
import 'package:shelter_super_app/feature/guard/kendaraan_operasional/kendaraan_operasional_screen.dart';
import 'package:shelter_super_app/feature/guard/pemakaian_telp/pemakaian_telp_screen.dart';
import 'package:shelter_super_app/feature/guard/pinjaman_kunci/pinjaman_kunci_screen.dart';

class GuardRoutes {
  GuardRoutes._();

  static final mainRoutes = [
    home,
    pinjamanKunci,
    pemakaianTelp,
    kendaraan,
    guest
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
}