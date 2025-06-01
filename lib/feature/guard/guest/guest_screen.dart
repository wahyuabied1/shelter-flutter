import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({super.key});

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Tamu",
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
            Divider(),
            DoubleListTile(
              firstIcon: Icons.calendar_today,
              firstTitle: 'Tanggal',
              firstSubtitle: DateTime.now().ddMMMyyyy(' '),
              secondIcon: Icons.access_time,
              secondTitle: 'Shift',
              secondSubtitle: '1',
            ),
            _buildExpandableSection(
                Icons.person_2_outlined, 'Nama Tamu', 'Dedi', [
              _buildListTile(
                  Icons.credit_card, 'No Identitas', '3148037104000003'),
              _buildListTile(Icons.apartment, 'Nama Perusahaan', 'B 1731 BB'),
            ]),
            _buildExpandableSection(
                Icons.person_2_outlined, 'Orang yang Ditemui', 'Pak Justinus', [
              _buildListTile(null, 'Departemen', 'Marketing'),
              _buildListTile(null, 'Keperluan', 'Meeting'),
            ]),
            DoubleListTile(
              firstIcon: Icons.person_2_outlined,
              firstTitle: 'Departemen',
              firstSubtitle: 'Marketing',
              secondIcon: Icons.task_outlined,
              secondTitle: 'Keperluan',
              secondSubtitle: 'Meeting',
            ),
            DoubleListTile(
              firstIcon: Icons.access_time_outlined,
              firstTitle: 'Jam Masuk',
              firstSubtitle: '06:00',
              secondIcon: Icons.access_time_outlined,
              secondTitle: 'Jam Keluar',
              secondSubtitle: '10:00',
            ),
            ListTile(
              onTap: (){},
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black12, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              title: const Text(
                'Image-232132.jpg',
                style: TextStyle(fontSize: 14,color: Colors.black54),
              ),
              leading: const Icon(Icons.image),
              trailing:Icon(Icons.download)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData? icon, String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading:
          icon != null ? Icon(icon, size: 20, color: Colors.grey[600]) : null,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      dense: true,
    );
  }

  Widget _buildExpandableSection(
      IconData icon, String title, String subtitle, List<Widget> children) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ExpansionTile(
          collapsedShape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          tilePadding: EdgeInsets.zero,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          children: children,
        ),
      ),
    );
  }
}
