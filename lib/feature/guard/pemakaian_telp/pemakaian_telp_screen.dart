import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_info_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class PemakaianTelpScreen extends StatefulWidget {
  const PemakaianTelpScreen({super.key});

  @override
  State<PemakaianTelpScreen> createState() => _PemakaianTelpScreenState();
}

class _PemakaianTelpScreenState extends State<PemakaianTelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Pemakaian Telpon",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade700,
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
              endDate: DateTime.now().ddMMyyyy('/'),
              startDate: DateTime.now().ddMMyyyy('/'),
              onChangeStartDate: (date) {},
              onChangeEndDate: (date) {},
              theme: ThemeWidget.red,
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
                  foregroundColor: Colors.red.shade700,
                  side: const BorderSide(color: Colors.red, width: 1.0),
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
                        color: Colors.red.shade700,
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
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return MultiChoiceBottomSheet(
                            title: "Shift",
                            choice: {
                              "Shift Pagi": false,
                              "Shift Siang": false,
                              "Sihft Malam": false,
                            },
                            theme: ThemeWidget.red,
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
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return MultiChoiceBottomSheet(
                              title: "Petugas",
                              choice: {
                                "Petugas Pos Bayar Rungkut": false,
                              },
                              theme: ThemeWidget.red,
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: SearchWidget(
                hint: 'Cari Peminjam',
                onSearch: (search) {},
                theme: ThemeWidget.red,
              ),
            ),
            const Text(
              'Menampilkan 2 Data',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.red.shade700,
                child: Text(
                  'Dedi'.initialName(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: const Text('Dedi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('Petugas Pos Bayer Rungkut'),
            ),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.now().ddMMMyyyy(' '),
              secondIcon: Icons.access_time,
              secondTitle: 'Shift',
              secondSubtitle: '1',
            ),
            const DoubleListTile(
              firstIcon: Icons.location_on_outlined,
              firstTitle: 'Ruang Kunci',
              firstSubtitle: 'Lobby',
              secondIcon: Icons.person_2_outlined,
              secondTitle: 'Nama Penerima',
              secondSubtitle: 'Dwi Sasongko',
            ),
            const DoubleListTile(
              firstIcon: Icons.phone,
              firstTitle: 'Ruang Kunci',
              firstSubtitle: '081234567890',
              secondIcon: Icons.phone_android_rounded,
              secondTitle: 'Device',
              secondSubtitle: '1',
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Deskripsi',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                'Telpon GM untuk input media',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.description_rounded),
            ),
            const SizedBox(height: 8),
            const DoubleInfoWidget(
              firstInfo: 'Mulai',
              firstValue: '08:00 WIB',
              secondInfo: 'Selesai',
              secondValue: '08:02 WIB',
            ),
          ],
        ),
      ),
    );
  }
}
