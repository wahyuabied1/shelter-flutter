import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/double_info_widget.dart';
import 'package:shelter_super_app/design/double_list_tile.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class MomScreen extends StatefulWidget {
  const MomScreen({super.key});

  @override
  State<MomScreen> createState() => _TransporterScreenState();
}

class _TransporterScreenState extends State<MomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "MoM",
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
              endDate: DateTime.now().ddMMyyyy('/'),
              startDate: DateTime.now().ddMMyyyy('/'),
              onChangeStartDate: (date) {},
              onChangeEndDate: (date) {},
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
                            title: "Jenis MoM",
                            choice: {
                              "Call": false,
                              "Visit": false,
                              "Scheduled": false,
                            },
                            theme: ThemeWidget.darkBlue,
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
                            Text('Jenis MoM'),
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
                              title: "Customer",
                              choice:  {
                                "RS Lombok 22": false,
                                "Bumi Menara": false,
                              },
                              theme: ThemeWidget.darkBlue,
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
                hint: 'Cari MoM',
                onSearch: (search) {},
                theme: ThemeWidget.darkBlue,
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
                backgroundColor: Color(0XFF154B79),
                child: Text(
                  'Siswanto'.initialName(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: const Text('Dibuat Oleh',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
              subtitle: const Text('Siswanto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Customer',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                'Karya Nusantara',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.person),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Tanggal',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                DateTime.now().ddMMMyyyy(' '),
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.access_time_sharp),
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Judul',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                'Notulen RSIA Lombok',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.title),
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Jenis MoM',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                'Visit',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.category_outlined),
            ),
            const ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Deskripsi',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Text(
                'Telfon GM untuk input media order dari AE cetak kuitansi cek kelengkapan dokumen yang sudah do ttd GM sebelum diserahkan kebagian keuangan buat rekap iklan kompetitor input / narik iklan baris closhing	',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),
              leading: Icon(Icons.description_outlined),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4,vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Lampiran',
                style: TextStyle(fontSize: 11,color: Colors.black54),
              ),
              subtitle: Row(
                children: [
                  const Text(
                    'Document-123.pdf',
                    style:
                    TextStyle(fontSize: 16, color: Color(0XFF154B79)),
                  ),
                  const Spacer(),
                  InkWell(
                    customBorder: new CircleBorder(),
                    onTap: (){},
                    child: const Icon(Icons.download,
                          color: Color(0XFF154B79)),
                  ),
                ],
              ),
              leading: Icon(Icons.picture_as_pdf
              ),
            ),
          ],
        ),
      ),
    );
  }
}
