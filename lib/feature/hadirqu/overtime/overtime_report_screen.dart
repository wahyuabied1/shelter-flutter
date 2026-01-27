import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/loading_employee_activity.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/overtime_header.dart';
import 'package:shelter_super_app/data/model/hadirqu_overtime_report_response.dart';
import 'package:shelter_super_app/feature/hadirqu/overtime/viewmodel/overtime_report_viewmodel.dart';

import '../../../design/loading_list_shimmer.dart';
import '../../../design/theme_widget.dart';

class OverTimeReportScreen extends StatelessWidget {
  const OverTimeReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OvertimeReportViewmodel()..init(),
      child: const _OverTimeReportView(),
    );
  }
}

class _OverTimeReportView extends StatefulWidget {
  const _OverTimeReportView();

  @override
  State<_OverTimeReportView> createState() => _OverTimeReportScreenState();
}

class _OverTimeReportScreenState extends State<_OverTimeReportView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OvertimeReportViewmodel>();

    return Container(
      color: ThemeWidget.greyBackground.colorTheme(),
      child: Column(
        children: [
          OverTimeHeader(
            startDate: vm.startDate.ddMMyyyy('/'),
            endDate: vm.endDate.ddMMyyyy('/'),
            onChangeStartDate: (date) {
              vm.updateDateRange(date as DateTime, vm.endDate);
            },
            onChangeEndDate: (date) {
              vm.updateDateRange(vm.startDate, date as DateTime);
            },
            onChangeSearch: (searchKey) {
              vm.updateSearchQuery(searchKey);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _filter(vm),
                  if (vm.isLoading)
                    const LoadingLineShimmer()
                  else
                    Text(
                      'Menampilkan ${vm.totalData} Data',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  const SizedBox(height: 8),

                  // Loading State
                  if (vm.isLoading)
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (_, __) => const LoadingEmployeeActivity(),
                      ),
                    )
                  // Error State
                  else if (vm.isError)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Text('Gagal memuat data'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => vm.getOvertimeReport(),
                              child: const Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      ),
                    )
                  // Empty State
                  else if (vm.overtimeList.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          vm.searchQuery.isNotEmpty ||
                                  vm.selectedDepartemenIds.isNotEmpty ||
                                  vm.selectedStatus.isNotEmpty
                              ? 'Tidak ada data yang sesuai filter'
                              : 'Tidak ada data lembur',
                        ),
                      ),
                    )
                  // Success - Show List
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: vm.overtimeList.length,
                        itemBuilder: (context, index) {
                          return _card(vm.overtimeList[index], index);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filter(OvertimeReportViewmodel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            _buildDepartemenFilter(vm),
            const SizedBox(width: 8),
            _buildStatusFilter(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartemenFilter(OvertimeReportViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableDepartemen.isEmpty) return;

        final Map<String, bool> departemenChoice = {};
        for (var dept in vm.availableDepartemen) {
          final key = '${dept.nama} (${dept.totalPegawai})';
          departemenChoice[key] = vm.selectedDepartemenIds.contains(dept.id);
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
          final selectedIds = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final deptName = key.split(' (')[0];
              final dept = vm.availableDepartemen.firstWhere(
                (d) => d.nama == deptName,
                orElse: () => OvertimeDepartemen(
                  id: 0,
                  nama: '',
                  totalPegawai: 0,
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            Text(
              vm.selectedDepartemenText,
              style: TextStyle(
                color: vm.selectedDepartemenIds.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedDepartemenIds.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedDepartemenIds.isNotEmpty
                  ? Colors.blue.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilter(OvertimeReportViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableStatus.isEmpty) return;

        final Map<String, bool> statusChoice = {};
        for (var status in vm.availableStatus) {
          statusChoice[status.nama] = vm.selectedStatus.contains(status.id);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Status",
              choice: statusChoice,
            );
          },
        );

        if (result != null) {
          final selectedIds = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final status = vm.availableStatus.firstWhere(
                (s) => s.nama == key,
                orElse: () => OvertimeStatus(id: 0, nama: ''),
              );
              if (status.id != 0) selectedIds.add(status.id);
            }
          });
          vm.updateStatusFilter(selectedIds);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: vm.selectedStatus.isEmpty
              ? Colors.transparent
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                vm.selectedStatus.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedStatusText,
              style: TextStyle(
                color: vm.selectedStatus.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedStatus.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedStatus.isNotEmpty
                  ? Colors.blue.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(OvertimeReport overtime, int index) {
    final code = 'KRY-${(index + 1).toString().padLeft(3, '0')}';

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
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
                  backgroundImage: overtime.pemohon.foto.isNotEmpty
                      ? NetworkImage(overtime.pemohon.foto)
                      : null,
                  child: overtime.pemohon.foto.isEmpty
                      ? Text(
                          overtime.pemohon.nama.initialName(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overtime.pemohon.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '${overtime.pemohon.idPegawai} • ${overtime.pemohon.departemen}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(fontSize: 12),
                  ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
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
                        const SizedBox(height: 4.0),
                        Text(
                          '${overtime.jumlahLembur} kali',
                          style: const TextStyle(color: Colors.black87),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.black26,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Durasi Lembur',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          overtime.durasi,
                          style: const TextStyle(color: Colors.black87),
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
