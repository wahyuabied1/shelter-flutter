import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_log_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_report_screen.dart';

class PresenceScreen extends StatefulWidget {
  final int tab;
  const PresenceScreen({super.key, required this.tab});

  @override
  State<PresenceScreen> createState() => _PresenceScreenState(tab: tab);
}

class _PresenceScreenState extends State<PresenceScreen>
    with SingleTickerProviderStateMixin {
  late int tab;
  _PresenceScreenState({required this.tab});
  late TabController tabController;

  @override
  void initState() {
    tabController =
        TabController(length: 2, vsync: this, initialIndex: tab);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != tab && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  void changePage(int newTab) {
    setState(() {
      tab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: Text(
          "Presensi Karyawan",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue.shade700,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Laporan Presensi'),
                Tab(text: 'Log Presensi'),
              ],
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 700),
              child: TabBarView(
                controller: tabController,
                children: [PresenceReportScreen(), PresenceLogScreen()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
