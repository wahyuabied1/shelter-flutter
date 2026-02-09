import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/data/model/task.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_info_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:shelter_super_app/feature/issuequ/keluhan/info_item.dart';
import 'package:shelter_super_app/feature/issuequ/keluhan/status_filter_chips.dart';

class KeluhanScreen extends StatefulWidget {
  const KeluhanScreen({super.key});

  @override
  State<KeluhanScreen> createState() => _TransporterScreenState();
}

class _TransporterScreenState extends State<KeluhanScreen> {
  final List<Task> tasks = [
    Task(
      status: 'Menunggu',
      priority: 'Rendah',
      priorityColor: Colors.green,
      title: 'Test Push Notif & Email',
      date: '10 May 2025',
      deadline: '15 May 2025',
      by: 'Abid Arkham',
    ),
    Task(
      status: 'Menunggu',
      priority: 'Tinggi',
      priorityColor: Colors.red,
      title: 'Test Push Notif & Email',
      date: '10 May 2025',
      deadline: '15 May 2025',
      by: 'Abid Arkham',
    ),
    Task(
      status: 'Menunggu',
      priority: 'Sedang',
      priorityColor: Colors.orange.shade700,
      title: 'Test Push Notif & Email',
      date: '10 May 2025',
      deadline: '15 May 2025',
      by: 'Abid Arkham',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Keluhan",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0XFF154B79),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DoubleDateWidget(
              endDate: DateTime.now(),
              startDate: DateTime.now(),
              onChangeDate: (date) {},
              theme: ThemeWidget.darkBlue,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Button action here
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0XFF154B79),
                  side: const BorderSide(color: Color(0XFF154B79), width: 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Export ke Excel',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF154B79),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StatusFilterChips(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: SearchWidget(
                hint: 'Cari Keluhan',
                onSearch: (search) {},
                theme: ThemeWidget.darkBlue,
              ),
            ),
            const Text(
              'Menampilkan 3 Data',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Left colored border
                        Container(
                          width: 4,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1D4ED8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Content
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Status & Priority
                                Row(
                                  children: [
                                    const Text(
                                      'Status: ',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(
                                      task.status,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text('|',
                                        style:
                                            TextStyle(color: Colors.black26)),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Prioritas: ',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: task.priorityColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        task.priority,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  task.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 12),
                                DoubleListTile(
                                  firstIcon: Icons.access_time,
                                  firstTitle: 'Tanggal',
                                  firstSubtitle: task.date,
                                  secondIcon: Icons.access_time,
                                  secondTitle: 'Deadline',
                                  secondSubtitle: task.deadline,
                                ),
                                DoubleListTile(
                                  firstIcon: Icons.person_2_outlined,
                                  firstTitle: 'Oleh',
                                  firstSubtitle: task.by,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
