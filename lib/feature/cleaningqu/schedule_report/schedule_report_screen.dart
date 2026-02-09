import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class ScheduleReportScreen extends StatefulWidget {
  const ScheduleReportScreen({super.key});

  @override
  State<ScheduleReportScreen> createState() => _ScheduleReportScreenState();
}

class _ScheduleReportScreenState extends State<ScheduleReportScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Laporan Terjadwal",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // DoubleDateWidget(
            //   endDate: DateTime.now().ddMMyyyy('/'),
            //   startDate: DateTime.now().ddMMyyyy('/'),
            //   onChangeDate: (date) {},
            //   onChangeEndDate: (date) {},
            //   theme: ThemeWidget.orange,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Button action here
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange.shade700,
                  side: const BorderSide(color: Colors.orange, width: 1.0),
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
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return MultiChoiceBottomSheet(
                            title: "Tempat",
                            choice: {
                              "LT 3 Ruang HRD": false,
                              "LT 3 RUANG SALES & MARKOM	": false,
                              "L3 TANGGA GED. LAMA	": false,
                              "L3 R. MAN MARKOM	": false,
                              "L1 R. STUDIO	": false,
                            },
                            theme: ThemeWidget.orange,
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
                              color: Colors.grey.shade300), // Light grey border
                        ),
                        child: const Row(
                          children: [
                            Text('Tempat'),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.black)
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return MultiChoiceBottomSheet(
                              title: "Jadwal",
                              choice: {
                                "Harian": false,
                                "Mingguan": false,
                                "Bulanan": false,
                              },
                              theme: ThemeWidget.orange,
                            );
                          },
                        );
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              Text('Jadwal'),
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: SearchWidget(
                hint: 'Cari Karyawan',
                theme: ThemeWidget.orange,
                onSearch: (search) {},
              ),
            ),
            const Text(
              'Menampilkan 2 Data',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return _card();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.orange.shade700,
                child: Text(
                  'Justinus William'.initialName(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: const Text(
                'Justinus William',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('justinuswilliam • KRY-001'),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 18),
                  SizedBox(width: 8),
                  Text('Tanggal: 31 Des 2024'),
                  Spacer(),
                  Icon(Icons.schedule, size: 18),
                  SizedBox(width: 8),
                  Text('Jadwal: Harian'),
                ],
              ),
            ),
            const Row(
              children: [
                Icon(Icons.location_on, size: 18),
                SizedBox(width: 8),
                Text('Lokasi: L2 TANGGA GED. LAMA'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: new BoxConstraints(
                      minHeight: 170,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: Column(
                      children: [
                        const Text('MULAI'),
                        const Text('06:42 WIB',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.location_on_outlined),
                          label: const Text(
                            'Lihat Maps',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.image),
                          label: const Text('image-23',
                              style: TextStyle(
                                color: Colors.black87,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    constraints: new BoxConstraints(
                      minHeight: 170,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('SELESAI',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Belum Dikerjakan',
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
