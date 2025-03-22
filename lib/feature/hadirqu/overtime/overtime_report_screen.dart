import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/overtime_header.dart';

class OverTimeReportScreen extends StatefulWidget {
  @override
  State<OverTimeReportScreen> createState() => _OverTimeReportScreenState();
}

class _OverTimeReportScreenState extends State<OverTimeReportScreen> {
  String _startDate = '01/11/2024';
  String _endDate = '27/11/2024';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          OverTimeHeader(
            startDate: _startDate,
            endDate: _endDate,
            onChangeStartDate: (date) {},
            onChangeEndDate: (date) {},
            onChangeSearch: (searchKey) {},
          ),
          _filter(),
          const Text(
            'Menampilkan 2 Data',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
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
    );
  }

  Widget _filter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
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
                    return MultiChoiceBottomSheet(title: "Departemen", choice: {
                      "Dept. Keamanan": false,
                      "Dept. Kebersihan": false,
                      "Dept. Quality Control": false,
                      "Dept. Produksi": false,
                      "Dept. Sales": false,
                    });
                  },
                );
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    // Rounded corners
                    border: Border.all(
                        color: Colors.grey.shade300), // Light grey border
                  ),
                  child: const Row(
                    children: [
                      Text('Departemen'),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                    ],
                  )),
            ),
            SizedBox(
              width: 4,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return MultiChoiceBottomSheet(title: "Site", choice: {
                      "Berjalan": false,
                      "Menunggu": false,
                      "Disetujui": false,
                      "Ditolak": false,
                    });
                  },
                );
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    // Rounded corners
                    border: Border.all(
                        color: Colors.grey.shade300), // Light grey border
                  ),
                  child: const Row(
                    children: [
                      Text('Site'),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.blue.shade700,
                  child: Text(
                    'Abdul Rahman Hakim'.initialName(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abdul Rahman Hakim',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        'abdulrahmanh • Staff Keamanan',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text('KRY-002', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black26,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Jumlah Lembur',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '5 kali',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.black26,
                              size: 16,
                            ),
                            SizedBox(width: 8,),
                            Text(
                              'Durasi Lembur',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '8 jam',
                          style: TextStyle(color: Colors.black87),
                        ),
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
