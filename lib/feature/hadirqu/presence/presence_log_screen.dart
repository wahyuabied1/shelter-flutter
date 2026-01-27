import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';

import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/export_bottom_sheet.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/viewmodel/presence_log_viewmodel.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/viewmodel/presence_report_viewmodel.dart';
import 'package:shelter_super_app/design/selection_filter_bottom_sheet.dart';
import 'package:shelter_super_app/data/model/hadirqu_presence_list_response.dart';
import 'package:intl/intl.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/widget/employee_card.dart';
import 'package:shelter_super_app/feature/hadirqu/presence/widget/presence_loading_card.dart';
import '../../../data/model/hadirqu_departement_filter_response.dart';
import '../../../design/loading_line_shimmer.dart';
import '../../../design/shimmer.dart';

class PresenceLogScreen extends StatelessWidget {
  const PresenceLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PresenceLogViewmodel()..init(),
      child: const _PresenceLogView(),
    );
  }
}

class _PresenceLogView extends StatefulWidget {
  const _PresenceLogView();

  @override
  State<_PresenceLogView> createState() => _PresenceLogScreenState();
}

class _PresenceLogScreenState extends State<_PresenceLogView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PresenceLogViewmodel>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _header(context, vm),
          _buildFilters(context, vm),
          const SizedBox(height: 12.0),

          // Employee Cards Count
          if (vm.isLoading)
            const LoadingLineShimmer()
          else
            Text(
              'Menampilkan ${vm.totalKaryawan} Karyawan',
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
            ),
          const SizedBox(height: 4.0),

          // Loading State
          if (vm.isLoading)
            const PresenceLoadingCard()
          // Error State
          else if (vm.isError)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text(
                      'Gagal memuat data',
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => vm.getPresenceList(),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            )
          else if (vm.presenceList.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.presenceList.length,
              itemBuilder: (context, index) {
                return EmployeeCard(employee: vm.presenceList[index], vm: vm);
              },
            )
          // Empty State
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Tidak ada data karyawan'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context, PresenceLogViewmodel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filter Departemen
          InkWell(
            onTap: () async {
              if (vm.availableDepartemen.isEmpty) return;

              // Buat map dari data API
              final Map<String, bool> departemenChoice = {};
              for (var dept in vm.availableDepartemen) {
                final key = '${dept.nama} (${dept.totalPegawai})';
                departemenChoice[key] =
                    vm.selectedDepartemenIds.contains(dept.id);
              }

              final result = await showModalBottomSheet<Map<String, bool>>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return MultiChoiceBottomSheet(
                    title: "Departemen",
                    choice: departemenChoice,
                  );
                },
              );

              if (result != null) {
                // Convert selected names back to IDs
                final selectedIds = <int>[];
                result.forEach((key, isSelected) {
                  if (isSelected) {
                    final deptName =
                        key.split(' (')[0]; // Extract name before count
                    final dept = vm.availableDepartemen.firstWhere(
                      (d) => d.nama == deptName,
                      orElse: () =>
                          Departemen(id: 0, nama: '', totalPegawai: 0),
                    );
                    if (dept.id != 0) selectedIds.add(dept.id);
                  }
                });
                vm.updateDepartemenFilter(selectedIds);
              }
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: vm.selectedDepartemenIds.isEmpty
                    ? Colors.transparent
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: vm.selectedDepartemenIds.isEmpty
                      ? Colors.grey.shade300
                      : Colors.blue,
                ),
              ),
              child: Row(
                children: [
                  Text(vm.selectedDepartemenText),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_sharp,
                      color: Colors.black)
                ],
              ),
            ),
          ),

          // Filter Jabatan
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: () async {
                if (vm.availableJabatan.isEmpty) return;

                // Buat map dari data API
                final Map<String, bool> jabatanChoice = {};
                for (var jabatan in vm.availableJabatan) {
                  jabatanChoice[jabatan] = vm.selectedJabatan.contains(jabatan);
                }

                final result = await showModalBottomSheet<Map<String, bool>>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return MultiChoiceBottomSheet(
                      title: "Jabatan",
                      choice: jabatanChoice,
                    );
                  },
                );

                if (result != null) {
                  // Get selected jabatan
                  final selectedJabatan = result.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                  vm.updateJabatanFilter(selectedJabatan);
                }
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: vm.selectedJabatan.isEmpty
                      ? Colors.transparent
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: vm.selectedJabatan.isEmpty
                        ? Colors.grey.shade300
                        : Colors.blue,
                  ),
                ),
                child: Row(
                  children: [
                    Text(vm.selectedJabatanText),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down_sharp,
                        color: Colors.black)
                  ],
                ),
              ),
            ),
          ),

          // Filter Kehadiran
          InkWell(
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return PresensiFilterBottomSheet(
                    title: "Jumlah Kehadiran",
                    initialFilter: vm.filterKehadiran != null
                        ? {
                            'operator': vm.filterKehadiranPersamaan,
                            'statusCode': vm.filterKehadiran,
                            'jumlah': vm.filterKehadiranNilai,
                          }
                        : null,
                  );
                },
              );

              if (result != null) {
                vm.updateKehadiranFilter(
                  statusCode: result['statusCode'],
                  operator: result['operator'],
                  nilai: result['jumlah'],
                );
              }
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: vm.hasKehadiranFilter
                    ? Colors.blue.shade50
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: vm.hasKehadiranFilter
                      ? Colors.blue
                      : Colors.grey.shade300,
                ),
              ),
              child: const Row(
                children: [
                  Text('Jumlah Kehadiran'),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, PresenceLogViewmodel vm) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Input Fields
          DoubleDateWidget(
            startDate: vm.startDate.ddMMyyyy('/'),
            endDate: vm.endDate.ddMMyyyy('/'),
            onChangeStartDate: (date) {
              final parsed = DateFormat('dd/MM/yyyy').parse(date);
              vm.updateDateRange(parsed, vm.endDate);
            },
            onChangeEndDate: (date) {
              final parsed = DateFormat('dd/MM/yyyy').parse(date);
              vm.updateDateRange(vm.startDate, parsed);
            },
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const ExportBottomSheet(),
                );
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
                  const SizedBox(width: 8.0),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
