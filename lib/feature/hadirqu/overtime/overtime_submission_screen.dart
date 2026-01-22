import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/routing/core/bottom_sheet_page.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/overtime_header.dart';

class OverTimeSubmissionScreen extends StatefulWidget {
  @override
  State<OverTimeSubmissionScreen> createState() =>
      _OverTimeSubmissionScreenState();
}

class _OverTimeSubmissionScreenState extends State<OverTimeSubmissionScreen> {
  final String _startDate = DateTime.now().ddMMyyyy('/');
  final String _endDate = DateTime.now().ddMMyyyy('/');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Text(
              'Menampilkan 2 Data',
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                    return MultiChoiceBottomSheet(title: "Status", choice: {
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
                      Text('Status'),
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
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User details row
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade700,
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Colors.blue.shade700,
                    child: Text(
                      'Justinus William'.initialName(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Justinus William',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'justinuswilliam • KRY-001',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.black54,
                        size: 14,
                      ),
                      SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          'Berjalan',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade200, // Border color
                  width: 2.0, // Border width
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pengajuan Lembur',
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.calendar_today, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Waktu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  SizedBox(height: 4),
                                  Text(
                                    '23 Des 2024',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.access_time, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Durasi',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  SizedBox(height: 4),
                                  Text(
                                    '1 jam',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          // Attachment
                          Row(children: [
                            Icon(
                              Icons.description_rounded,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Bukti Mulai',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.image, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              const Text(
                                'image-232123.jpg',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.download,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                          const Divider(),
                          // Description
                          Row(children: [
                            Icon(
                              Icons.density_medium,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Keterangan',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                          const SizedBox(height: 4),
                          const Text(
                            'Menyelesaikan sisa design yang belum kelar',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                        ],
                      )),
                ],
              ),
            ),
          )
          // Details section
        ],
      ),
    );
  }
}
