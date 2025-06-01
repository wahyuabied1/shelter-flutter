import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/detail/employee_detai_card.dart';

class EmployeePresentDetailScreen extends StatefulWidget {
  const EmployeePresentDetailScreen({super.key});

  @override
  State<EmployeePresentDetailScreen> createState() =>
      _EmployeePresentDetailScreenState();
}

class _EmployeePresentDetailScreenState
    extends State<EmployeePresentDetailScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Karyawan Hadir",
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
      body: Container(
        color: Colors.grey.shade100,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                    hint: 'Cari Karyawan',
                    onSearch: (search) {},
                    theme: ThemeWidget.blue,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: -1));
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color: Colors
                                      .grey.shade300), // Light grey border
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                              width: 240,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                // Rounded corners
                                border: Border.all(
                                    color: Colors
                                        .grey.shade300), // Light grey border
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined),
                                      const SizedBox(width: 8),
                                      Text(selectedDate.eeeeddMMMyyyy(' ')),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: 1));
                            });
                          },
                          child: Container(
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color: Colors
                                      .grey.shade300), // Light grey border
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return MultiChoiceBottomSheet(
                              title: "Shift",
                              choice: {
                                "Pagi": false,
                                "Siang": false,
                                "Sore": false,
                                "Malam": false,
                              },
                              theme: ThemeWidget.blue,
                            );
                          },
                        );
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            // Rounded corners
                            border: Border.all(
                                color:
                                    Colors.grey.shade300), // Light grey border
                          ),
                          child: const Row(
                            children: [
                              Text('Shift'),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_sharp,
                                  color: Colors.black)
                            ],
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) {
                              return MultiChoiceBottomSheet(
                                title: "Petugas",
                                choice: {
                                  "Petugas Pos Bayar Rungkut": false,
                                },
                                theme: ThemeWidget.blue,
                              );
                            },
                          );
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              // Rounded corners
                              border: Border.all(
                                  color: Colors
                                      .grey.shade300), // Light grey border
                            ),
                            child: const Row(
                              children: [
                                Text('Petugas'),
                                SizedBox(width: 4),
                                Icon(Icons.keyboard_arrow_down_sharp,
                                    color: Colors.black)
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _listCard(),
          ],
        ),
      ),
    );
  }

  Widget _listCard() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: const [
        EmployeeCard(
          name: 'Justinus William',
          id: 'KRY-001',
          time: '07:00 - 17:00',
          site: 'Amerta Indah Otsuka Kejayan',
          statusIcon: 'H',
          statusColor: 'green',
          imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        ),
        EmployeeCard(
          name: 'Abdul Rahman Hakim',
          id: 'KRY-002',
          time: '07:00 - 13:28',
          site: 'Amerta Indah Otsuka Kejayan',
          statusIcon: 'P',
          statusColor: 'yellow',
          imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
        ),
        EmployeeCard(
          name: 'Ratna Sari Dewi',
          id: 'KRY-005',
          time: '08:20 - 17:00',
          site: 'Amerta Indah Otsuka Kejayan',
          statusIcon: 'T',
          statusColor: 'orange',
          imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        ),
        EmployeeCard(
          name: 'William Tanuwijaya',
          id: 'KRY-006',
          time: '07:00 - 17:00',
          site: 'Amerta Indah Otsuka Kejayan',
          statusIcon: 'H',
          statusColor: 'green',
          imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2999),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue.shade700, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
