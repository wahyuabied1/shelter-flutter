import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/data/model/summary_response.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  TextEditingController employeeController = TextEditingController();
  var listData = [
    SummaryResponse(type: 'Harian', total: '100', done: '90',notYet: '10',percentage: '90',),
    SummaryResponse(type: 'Mingguan', total: '1000', done: '900',notYet: '100',percentage: '90',),
    SummaryResponse(type: 'Bulanan', total: '2000', done: '1800',notYet: '200',percentage: '90',),
  ];
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    employeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Laporan Absensi",
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return _card(listData[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(SummaryResponse data) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 2,vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'JADWAL',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Jadwal ${data.type}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoCard('Total', data.total ??'-'),
                const SizedBox(width: 8),
                _buildInfoCard('Sudah', data.done ??'-'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildInfoCard('Belum', data.notYet ??'-'),
                const SizedBox(width: 8),
                _buildInfoCard('Persentase', '${data.percentage}%' ??'-'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
          ],
        ),
      ),
    );
  }
}
