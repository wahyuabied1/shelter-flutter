import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/rekap_tile.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/report_status_chip.dart';

class ReportDashboardScreen extends StatefulWidget {
  const ReportDashboardScreen({super.key});

  @override
  State<ReportDashboardScreen> createState() => _ReportDashboardScreenState();
}

class _ReportDashboardScreenState extends State<ReportDashboardScreen> {
  DateTime selectedDate = DateTime.now();

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
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Report Absensi",
          style: TextStyle(
            fontSize: 20,
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners
                            border: Border.all(
                                color:
                                    Colors.grey.shade300), // Light grey border
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
                          onTap: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: -1));
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color:
                                      Colors.grey.shade300), // Light grey border
                            ),
                            child: const Icon(
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
                          onTap: () {
                            _selectDate(context);
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                              width: 240.w,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                // Rounded corners
                                border: Border.all(
                                    color: Colors
                                        .grey.shade300), // Light grey border
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined),
                                      const SizedBox(width: 8),
                                      Text(selectedDate.eeeeddMMMyyyy(' ')),
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
                          onTap: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: 1));
                            });
                          },
                          child: Container(
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              // Rounded corners
                              border: Border.all(
                                  color:
                                      Colors.grey.shade300), // Light grey border
                            ),
                            child: const Icon(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
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
                        animationDuration: const Duration(milliseconds: 500),
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
                      const SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 2.4 / 2,
                        ),
                        children: const [
                          ReportStatusChip(
                            label: "T",
                            title: "Terlambat",
                            subtitle: "10 Orang",
                            color: Colors.orange,
                          ),
                          ReportStatusChip(
                            label: "P",
                            title: "Pulang Cepat",
                            subtitle: "5 Orang",
                            color: Colors.orange,
                          ),
                          ReportStatusChip(
                            label: "?",
                            title: "Di luar wilayah",
                            subtitle: "6 Orang",
                            color: Colors.orange,
                          ),
                          ReportStatusChip(
                            label: "T",
                            title: "Terlambat & di luar wilayah",
                            subtitle: "9 Orang",
                            color: Colors.orange,
                          ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
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
                        animationDuration: const Duration(milliseconds: 500),
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
                      const SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 2.4 / 2,
                        ),
                        children: const [
                          ReportStatusChip(
                            label: 'T',
                            title: 'Terlambat',
                            subtitle: "4 Orang",
                            color: Colors.red,
                          ),
                          ReportStatusChip(
                            label: "P",
                            title: "Pulang Cepat",
                            subtitle: "2 Orang",
                            color: Colors.red,
                          ),
                          ReportStatusChip(
                            label: "?",
                            title: "Di luar wilayah",
                            subtitle: "1 Orang",
                            color: Colors.red,
                          ),
                          ReportStatusChip(
                            label: "T",
                            title: "Terlambat & di luar wilayah",
                            subtitle: "2 Orang",
                            color: Colors.red,
                          ),
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
                      const Text(
                        "Rekap Waktu Absensi",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 4 / 2,
                        ),
                        children: const [
                          RekapTile(title: 'Clock-in pertama', value: '07.30'),
                          RekapTile(
                              title: 'Clock-out terakhir', value: '18.45'),
                          RekapTile(title: 'Rerata clock-in', value: '07.45'),
                          RekapTile(title: 'Rerata clock-out', value: '17.20'),
                          RekapTile(
                              title: 'Rerata jam kerja', value: '7 j 30 m'),
                          RekapTile(
                              title: 'Rerata istirahat', value: '1 j 15 m'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2999),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue.shade700, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
