import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/hadirqu_double_date_widget.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';

class PresenceReportScreen extends StatefulWidget{
  @override
  State<PresenceReportScreen> createState() => _PresenceReportScreenState();
}

class _PresenceReportScreenState extends State<PresenceReportScreen> {
  String _startDate = '01/11/2024';
  String _endDate = '27/11/2024';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _header(context),
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
                            title: "Departemen",
                            choice: {
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
                          Text('Departemen'),
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
                              title: "Jabatan",
                              choice: {
                                "Staff": false,
                                "Staff Senior": false,
                                "Supervisor": false,
                              });
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
                              color: Colors.grey.shade300), // Light grey border
                        ),
                        child: const Row(
                          children: [
                            Text('Jabatan'),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.black)
                          ],
                        )),
                  ),
                ),
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
                            title: "Jumlah Kehadiran",
                            choice: {
                              "Group 1": false,
                              "Group 2": false,
                            });
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
                            color: Colors.grey.shade300), // Light grey border
                      ),
                      child: Row(
                        children: [
                          Text('Jumlah Kehadiran'),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.black)
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          // Employee Cards
          Text(
            'Menampilkan 2 Karyawan',
            style: TextStyle(color: Colors.black54,fontSize: 12),
          ),
          SizedBox(height: 4.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return _cardEmployee();
            },
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Input Fields
          HadirQuDoubleDateWidget(
            startDate: _startDate,
            endDate: _endDate,
            onChangeStartDate: (date){

            },
            onChangeEndDate: (date){

            },
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Button action here
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade700,
                side: const BorderSide(color: Colors.blue, width: 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Export Log Presensi',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardEmployee() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                child: Text(
                  "Disma Ramadani".initialName(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add your image
                radius: 20.0,
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Disma Ramadani',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'abdulrahmanh • Staff Keamanan',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'KRY-002',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Presence Summary
          const Text('Rangkuman Presensi',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),

          Row(
            children: [
              // Hadir
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('16'),
              ),
              const SizedBox(width: 4.0),
              const Text('Hadir'),

              const SizedBox(width: 16.0),

              // Di luar batas wilayah
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('4'),
              ),
              const SizedBox(width: 4.0),
              const Text('Di luar batas wilayah'),
            ],
          ),

          const SizedBox(height: 16.0),

          // Detail Link
          Center(
            child: Text(
              'Lihat Detail ▼',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String label, String count, Color color) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 12.0)),
      ],
    );
  }
}