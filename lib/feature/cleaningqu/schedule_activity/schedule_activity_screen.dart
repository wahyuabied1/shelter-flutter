import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/search_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class ScheduleActivityScreen extends StatefulWidget {
  const ScheduleActivityScreen({super.key});

  @override
  State<ScheduleActivityScreen> createState() => _ScheduleActivityScreenState();
}

class _ScheduleActivityScreenState extends State<ScheduleActivityScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Laporan Aktivitas",
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
            DoubleDateWidget(
              endDate: DateTime.now().ddMMyyyy('/'),
              startDate: DateTime.now().ddMMyyyy('/'),
              onChangeStartDate: (date) {},
              onChangeEndDate: (date) {},
              theme: ThemeWidget.orange,
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: SearchWidget(
                hint: 'Cari Karyawan',
                theme: ThemeWidget.orange,
                onSearch: (search) {},
              )
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
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.orange.shade700,
                  child: Text(
                    'Justinus William'.initialName(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Justinus William',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('@justinuswilliam • KRY-001',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const Divider(height: 20),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on),
              title: Text(
                'Lokasi',
                style: TextStyle(fontSize: 11, color: Colors.black45),
              ),
              subtitle: Text(
                'L2 TANGGA GED. LAMA',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.description),
              title: Text(
                'Deskripsi',
                style: TextStyle(fontSize: 11, color: Colors.black45),
              ),
              subtitle: Text(
                'Menyiapkan ruang meeting',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: const Column(
                      children: [
                        Text('Mulai'),
                        Text('11:05 WIB',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: const Column(
                      children: [
                        Text('Selesai'),
                        Text('11:05 WIB',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  // Rounded corners
                  border: Border.all(
                      color: Colors.grey.shade300), // Light grey border
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('Lihat Maps',
                        style: TextStyle(color: Colors.blue.shade700)),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  // Rounded corners
                  border: Border.all(
                      color: Colors.grey.shade300), // Light grey border
                ),
                child: Row(
                  children: [
                    const Icon(Icons.image_outlined, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('image-232123.jpg',
                        style: TextStyle(color: Colors.blue.shade700)),
                    const Spacer(),
                    const Icon(
                      Icons.download,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
