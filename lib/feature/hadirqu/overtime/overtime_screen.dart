import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/feature/hadirqu/overtime/overtime_report_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/overtime/overtime_submission_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_log_screen.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/presence_report_screen.dart';

class OverTimeScreen extends StatefulWidget {
  const OverTimeScreen({super.key});

  @override
  State<OverTimeScreen> createState() => _OverTimeScreenState();
}

class _OverTimeScreenState extends State<OverTimeScreen>
    with SingleTickerProviderStateMixin {
  late int tab;
  late TabController tabController;

  @override
  void initState() {
    tab = 0;
    tabController = TabController(length: 2, vsync: this, initialIndex: tab);
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
          "Lembur Karyawan",
          style: TextStyle(
            fontSize: 20,
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
                Tab(text: 'Pengajuan Lembur'),
                Tab(text: 'Laporan Lembur'),
              ],
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 700),
              child: TabBarView(
                controller: tabController,
                children: [
                  OverTimeSubmissionScreen(),
                  OverTimeReportScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
