import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_log_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_report_screen.dart';

class PresenceScreen extends StatefulWidget {
  @override
  State<PresenceScreen> createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> with SingleTickerProviderStateMixin{
  late int currentTab;
  late TabController tabController;

  @override
  void initState() {
    currentTab = 0;
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentTab && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  void changePage(int newTab) {
    setState(() {
      currentTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
              constraints:
              const BoxConstraints(minHeight: 200, maxHeight: 450),
              child: TabBarView(
                controller: tabController,
                children: [
                  PresenceReportScreen(),
                  PresenceLogScreen()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
