import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_info_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class PatrolFindingScreen extends StatefulWidget {
  const PatrolFindingScreen({super.key});

  @override
  State<PatrolFindingScreen> createState() => _PatrolFindingScreenState();
}

class _PatrolFindingScreenState extends State<PatrolFindingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Checklist Patrol",
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
        color: Colors.grey.shade100,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 4),
              color: Colors.white,
              child: Column(
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                    hint: 'Cari Checklist Patrol',
                    onSearch: (search) {},
                    theme: ThemeWidget.red,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Menampilkan 2 Data',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  _listCard()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DateTime.now().ddMMyyyy('/'),
            style: TextStyle(color: Colors.black54)),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return _card();
          },
        ),
      ],
    );
  }

  Widget _card() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          children: [
            Container(
              color: Colors.white,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: const Text('Petugas Pos Bayer Rungkut'),
                  ),
                  DoubleListTile(
                    firstIcon: Icons.date_range,
                    firstTitle: 'Tanggal',
                    firstSubtitle: DateTime.now().ddMMMyyyy(' '),
                    secondIcon: Icons.access_time,
                    secondTitle: 'Shift',
                    secondSubtitle: 'Pagi',
                  ),
                  DoubleListTile(
                    firstIcon: Icons.access_time,
                    firstTitle: 'Waktu Scan',
                    firstSubtitle: DateTime.now().hHmm(),
                    secondIcon: Icons.location_on_outlined,
                    secondTitle: 'Tempat',
                    secondSubtitle: 'L2 TANGGA GED. LAMA',
                  ),
                  const ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Keterangan',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    subtitle: Text(
                      'input media order dari AE cetak kuitansi cek kelengkapan dokumen yang sudah do ttd GM sebelum diserahkan kebagian keuangan buat rekap iklan kompetitor input / narik iklan baris closhing	',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    leading: Icon(Icons.description_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const DoubleInfoWidget(
                    firstInfo: 'Kriteria',
                    firstValue: 'Normal',
                    secondInfo: 'Status',
                    secondValue: 'Sudak Di Cek',
                    theme: ThemeWidget.green,
                    bg: Colors.white,
                  ),
                  SizedBox(height: 12),
                  ListTile(
                    tileColor: Colors.white,
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    title: const Text(
                      'Lihat Maps',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    leading: const Icon(Icons.location_on),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                      tileColor: Colors.white,
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      title: const Text(
                        'Image-232132.jpg',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      leading: const Icon(Icons.image),
                      trailing: Icon(Icons.download)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
