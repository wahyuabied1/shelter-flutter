import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/widget/rekap_tile.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/viewmodel/report_dashboard_viewmodel.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/widget/report_status_chip.dart';
import 'package:shelter_super_app/feature/hadirqu/report_dashboard/widget/chart_loading_card.dart';
import 'package:shelter_super_app/feature/routes/hadirqu_routes.dart';

import '../../../data/model/hadirqu_report_response.dart';
import '../../../design/multi_choice_bottom_sheet.dart';

class ReportDashboardScreen extends StatelessWidget {
  const ReportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportDashboardViewmodel()..init(),
      child: const _ReportDashboardView(),
    );
  }
}

class _ReportDashboardView extends StatefulWidget {
  const _ReportDashboardView();

  @override
  State<_ReportDashboardView> createState() => _ReportDashboardScreenState();
}

class _ReportDashboardScreenState extends State<_ReportDashboardView> {
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
  Widget build(BuildContext context) {
    final vm = context.watch<ReportDashboardViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
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
                  // Filter Departemen
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        // 1. Buat map pilihan dari data API
                        final Map<String, bool> mapChoice = {
                          for (var d in vm.departemenList)
                            '${d.nama} (${d.totalPegawai})':
                                vm.isDepartemenSelected(d.id ?? 0)
                        };

                        // 2. Buka bottom sheet & tunggu hasil
                        final result =
                            await showModalBottomSheet<Map<String, bool>>(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return MultiChoiceBottomSheet(
                              title: "Filter Departemen",
                              choice: mapChoice,
                            );
                          },
                        );

                        // 3. Kalau user pencet simpan
                        if (result != null) {
                          final selectedIds = <int>[];

                          result.forEach((key, isSelected) {
                            if (isSelected) {
                              // ambil nama asli sebelum "(total)"
                              final name = key.split(' (')[0];

                              final dept = vm.departemenList.firstWhere(
                                (d) => d.nama == name,
                                orElse: () => Departemen(
                                    id: 0, nama: '', totalPegawai: 0),
                              );

                              if (dept.id != 0) {
                                selectedIds.add(dept.id!);
                              }
                            }
                          });

                          // 4. Update ke viewmodel → otomatis hit API
                          vm.updateDepartemenFilter(selectedIds);
                        }
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: vm.selectedDepartemenIds.isEmpty
                              ? Colors.transparent
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: vm.selectedDepartemenIds.isEmpty
                                ? Colors.grey.shade300
                                : Colors.blue,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.people),
                                const SizedBox(width: 8),
                                Text(vm.selectedDepartemenText),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_down_sharp,
                                color: Colors.black)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date Navigation
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: vm.isLoading
                              ? null
                              : () {
                                  vm.changeDate(
                                    vm.selectedDate
                                        .subtract(const Duration(days: 1)),
                                  );
                                },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 20,
                              color: vm.isLoading ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: vm.isLoading
                              ? null
                              : () => _selectDate(context, vm),
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
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined),
                                    const SizedBox(width: 8),
                                    Text(vm.selectedDate.eeeeddMMMyyyy(' ')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: vm.isLoading
                              ? null
                              : () {
                                  vm.changeDate(
                                    vm.selectedDate
                                        .add(const Duration(days: 1)),
                                  );
                                },
                          child: Container(
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: vm.isLoading ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content sections with loading states
            vm.isLoading
                ? const ChartLoadingCard()
                : Column(
                    children: [
                      _buildPresentSection(context, vm),
                      _buildAbsentSection(context, vm),
                      _buildRekapSection(context, vm),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresentSection(
      BuildContext context, ReportDashboardViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Karyawan Hadir"),
                  TextButton(
                    onPressed: () {
                      context
                          .pushNamed(HadirQuRoutes.employeePresentDetail.name!);
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(color: Colors.blue.shade700),
                    ),
                  ),
                ],
              ),
              PieChart(
                dataMap: vm.presentChart.isEmpty
                    ? {"Belum ada data": 1}
                    : vm.presentChart,
                animationDuration: const Duration(milliseconds: 500),
                chartLegendSpacing: 24,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: presentColor,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 16,
                centerText: vm.centerPresentText,
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
              ),
              const SizedBox(height: 16),
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
                  ReportStatusChip(
                    label: "T",
                    title: "Terlambat",
                    subtitle: "${vm.data?.terlambat ?? 0} Orang",
                    color: Colors.orange,
                  ),
                  ReportStatusChip(
                    label: "P",
                    title: "Pulang Cepat",
                    subtitle: "${vm.data?.pulangCepat ?? 0} Orang",
                    color: Colors.orange,
                  ),
                  ReportStatusChip(
                    label: "?",
                    title: "Di luar wilayah",
                    subtitle: "${vm.data?.diluarLokasi ?? 0} Orang",
                    color: Colors.orange,
                  ),
                  ReportStatusChip(
                    label: "T",
                    title: "Terlambat & di luar wilayah",
                    subtitle: "${vm.data?.diluarLokasi ?? 0} Orang",
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbsentSection(
      BuildContext context, ReportDashboardViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Karyawan Tidak Hadir"),
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
                dataMap: vm.absentChart.isEmpty
                    ? {"Belum ada data": 1}
                    : vm.absentChart,
                animationDuration: const Duration(milliseconds: 500),
                chartLegendSpacing: 24,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: absentColor,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 16,
                centerText: vm.centerNotPresentText,
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
              ),
              const SizedBox(height: 16),
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
                  ReportStatusChip(
                    label: 'A',
                    title: 'Alpha',
                    subtitle: "${vm.data?.alpha ?? 0} Orang",
                    color: Colors.red,
                  ),
                  ReportStatusChip(
                    label: "S",
                    title: "Sakit",
                    subtitle: "${vm.data?.sakit ?? 0} Orang",
                    color: Colors.red,
                  ),
                  ReportStatusChip(
                    label: "I",
                    title: "Izin",
                    subtitle: "${vm.data?.izin ?? 0} Orang",
                    color: Colors.red,
                  ),
                  ReportStatusChip(
                    label: "C",
                    title: "Cuti",
                    subtitle: "${vm.data?.cuti ?? 0} Orang",
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRekapSection(BuildContext context, ReportDashboardViewmodel vm) {
    return Padding(
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4 / 2,
                ),
                children: [
                  RekapTile(
                    title: 'Clock-in pertama',
                    value: vm.clockInPertama.toHourSafe(),
                  ),
                  RekapTile(
                    title: 'Clock-out terakhir',
                    value: vm.clockOutTerakhir.toHourSafe(),
                  ),
                  RekapTile(
                    title: 'Rerata clock-in',
                    value: vm.clockInAvg.toHourSafe(),
                  ),
                  RekapTile(
                    title: 'Rerata clock-out',
                    value: vm.clockOutAvg.toHourSafe(),
                  ),
                  RekapTile(title: 'Rerata jam kerja', value: vm.durasiAvg),
                  RekapTile(
                      title: 'Rerata istirahat', value: vm.durasiIstirahatAvg),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    ReportDashboardViewmodel vm,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: vm.selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2999),
    );

    if (picked != null) {
      vm.changeDate(picked);
    }
  }
}
