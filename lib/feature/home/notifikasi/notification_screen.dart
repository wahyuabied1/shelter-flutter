import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Notifikasi",
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
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.filter_alt),
                hintText: 'Filter',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),

          // Notification List
          Expanded(
            child: ListView(
              children: [
                // Today's Notifications
                NotificationSection(
                  sectionTitle: 'HARI INI, 12 NOV 2024',
                  notifications: [
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                  ],
                ),

                // Yesterday's Notifications
                NotificationSection(
                  sectionTitle: 'KEMARIN, 11 NOV 2024',
                  notifications: [
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                    'Pengajuan Cuti dari Agus Hariyono',
                  ],
                ),
                SizedBox(height: 80.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String sectionTitle;
  final List<String> notifications;

  const NotificationSection({
    super.key,
    required this.sectionTitle,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Card(
            color: Colors.white,
            elevation: 4,
            child: Column(
                children: notifications.asMap().entries.map((entry) {
              int index = entry.key;
              String notification = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      AppAssets.ilIconHadirqu,
                      width: 30.w,
                      height: 30.h,
                    ),
                    title: Text(notification),
                    subtitle: const Text('HadirQu'),
                    onTap: () {},
                  ),
                  index == notifications.length - 1
                      ? const SizedBox()
                      : const Divider(height: 1)
                ],
              );
            }).toList()),
          ),
        ],
      ),
    );
  }
}
