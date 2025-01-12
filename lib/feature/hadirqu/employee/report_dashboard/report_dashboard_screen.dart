import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';

class ReportDashboardScreen extends StatefulWidget {
  const ReportDashboardScreen({super.key});

  @override
  State<ReportDashboardScreen> createState() => _ReportDashboardScreenState();
}

class _ReportDashboardScreenState extends State<ReportDashboardScreen> {
  Map<String, double> present = {
    "Tepat Waktu": 10,
    "Terlambat & Di luar wilayah": 5,
    "Di luar wilayah": 6,
    "Terlambat": 4,
    "Pulang cepat": 5,
  };
  Map<String, double> absent = {
    "Sakit": 4,
    "Izin": 4,
    "Cuti": 1,
    "Alpa": 1,
  };

  final presentColor = <Color>[
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.greenAccent,
  ];

  final absentColor = <Color>[
    Colors.green,
    Colors.greenAccent,
    Colors.orange,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        title: Text(
          "Report Absensi",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            // Filter Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners
                            border: Border.all(
                                color: Colors.grey.shade300), // Light grey border
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.people),
                                  SizedBox(width: 8),
                                  Text('Semua Departemen'),
                                ],
                              ),
                              Icon(Icons.keyboard_arrow_down_sharp,
                                  color: Colors.black)
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color: Colors.grey.shade300), // Light grey border
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                              width: 240.w,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                // Rounded corners
                                border: Border.all(
                                    color:
                                        Colors.grey.shade300), // Light grey border
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today_outlined),
                                      SizedBox(width: 8),
                                      Text(DateTime.now().eeeeddMMMyyyy(' ')),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color: Colors.grey.shade300), // Light grey border
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Karyawan Hadir Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Karyawan Hadir",
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      PieChart(
                        dataMap: present,
                        animationDuration: Duration(milliseconds: 500),
                        chartLegendSpacing: 24,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: presentColor,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 16,
                        centerText: "30/40",
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendTextStyle: TextStyle(fontSize: 10),
                          legendShape: BoxShape.circle,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                          decimalPlaces: 0,
                        ),
                        // gradientList: ---To add gradient colors---
                        // emptyColorGradient: ---Empty Color gradient---
                      ),
                      SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 2.4 / 2,
                        ),
                        children: [
                          _buildStatusChip("T", "Terlambat", "10 Orang"),
                          _buildStatusChip("P", "Pulang Cepat", "5 Orang"),
                          _buildStatusChip("?", "Di luar wilayah", "6 Orang"),
                          _buildStatusChip(
                              "T", "Terlambat & di luar wilayah", "9 Orang"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Karyawan Tidak Hadir Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Karyawan Tidak Hadir",
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      PieChart(
                        dataMap: absent,
                        animationDuration: Duration(milliseconds: 500),
                        chartLegendSpacing: 24,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: absentColor,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 16,
                        centerText: "10",
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendTextStyle: TextStyle(fontSize: 10),
                          legendShape: BoxShape.circle,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                          decimalPlaces: 0,
                        ),
                        // gradientList: ---To add gradient colors---
                        // emptyColorGradient: ---Empty Color gradient---
                      ),
                      SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 2.4 / 2,
                        ),
                        children: [
                          _buildStatusChip("T", "Terlambat", "4 Orang",color: Colors.red),
                          _buildStatusChip("P", "Pulang Cepat", "2 Orang",color: Colors.red),
                          _buildStatusChip("?", "Di luar wilayah", "1 Orang",color: Colors.red),
                          _buildStatusChip(
                              "T", "Terlambat & di luar wilayah", "2 Orang",color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Rekap Waktu Absensi Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rekap Waktu Absensi",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4/2,
                        ),
                        children: [
                          _buildRekapTile("Clock-in pertama", "07.30"),
                          _buildRekapTile("Clock-out terakhir", "18.45"),
                          _buildRekapTile("Rerata clock-in", "07.45"),
                          _buildRekapTile("Rerata clock-out", "17.20"),
                          _buildRekapTile("Rerata jam kerja", "7 j 30 m"),
                          _buildRekapTile("Rerata istirahat", "1 j 15 m"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, String title, String subtitle,
      {Color color = Colors.orange}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        // Rounded corners
        border: Border.all(
            color: Colors.grey.shade300), // Light grey border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              title,
                style: const TextStyle(
                  fontSize: 12,
                )
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRekapTile(String title, String value) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        // Rounded corners
        border: Border.all(
            color: Colors.grey.shade300), // Light grey border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
