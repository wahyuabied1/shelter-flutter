import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/design/loading_employee_activity.dart';

import '../../../../../data/model/hadirqu_attendance_detail_response.dart';
import '../../../../../data/model/hadirqu_departement_filter_response.dart';
import '../../../../../design/multi_choice_bottom_sheet.dart';
import '../../../../../design/search_widget.dart';
import '../../../../../design/theme_widget.dart';
import '../../viewmodel/report_dashboard_viewmodel.dart';

class EmployeePresentDetailCard extends StatefulWidget {
  final bool isPresent;

  const EmployeePresentDetailCard({super.key, required this.isPresent});

  @override
  State<EmployeePresentDetailCard> createState() =>
      _EmployeePresentDetailViewState();
}

class _EmployeePresentDetailViewState extends State<EmployeePresentDetailCard> {
  String searchQuery = '';
  List<String> selectedJabatan = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final vm = context.read<ReportDashboardViewmodel>();
    if (widget.isPresent) {
      vm.getPresentDetail();
    } else {
      vm.getAbsentDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportDashboardViewmodel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            centerTitle: false,
            leading: const BackButton(color: Colors.white),
            title: Text(
              widget.isPresent ? 'Karyawan Hadir' : 'Karyawan Tidak Hadir',
              style: const TextStyle(
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
            color: Colors.grey.shade100,
            child: Column(
              children: [
                _buildFilterSection(vm),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildDepartemenFilter(vm),
                        const SizedBox(width: 12),
                        _buildJabatanFilter(vm),
                        const SizedBox(width: 12),
                        _buildStatusFilter(vm),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildContent(vm)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(ReportDashboardViewmodel vm) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(
                  hint: 'Cari Karyawan',
                  onSearch: (search) {
                    setState(() {
                      searchQuery = search.toLowerCase();
                    });
                  },
                  theme: ThemeWidget.blue,
                ),
                const SizedBox(height: 8),
                _buildDateSelector(vm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(ReportDashboardViewmodel vm) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              vm.changeDate(vm.selectedDate.add(const Duration(days: -1)));
              _loadData();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                _selectDate(context, vm);
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        ),
        SizedBox(width: 8.w),
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              vm.changeDate(vm.selectedDate.add(const Duration(days: 1)));
              _loadData();
            },
            child: Container(
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepartemenFilter(ReportDashboardViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.departemenList.isEmpty) return;

        final Map<String, bool> departemenChoice = {};
        for (var dept in vm.departemenList) {
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
              final dept = vm.departemenList.firstWhere(
                (d) => d.nama == deptName,
                orElse: () => Departemen(id: 0, nama: '', totalPegawai: 0),
              );
              if (dept.id != 0) selectedIds.add(dept.id);
            }
          });
          vm.updateDepartemenFilter(selectedIds);
          _loadData();
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

  Widget _buildJabatanFilter(ReportDashboardViewmodel vm) {
    // Gunakan cached jabatan list agar tidak hilang saat loading
    final jabatanList = widget.isPresent ? vm.presentJabatanList : vm.absentJabatanList;

    if (jabatanList.isEmpty) {
      return InkWell(
        onTap: null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            children: [
              Text('Jabatan', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () async {
        if (jabatanList.isEmpty) return;

        final Map<String, bool> jabatanChoice = {};
        for (var jabatan in jabatanList) {
          jabatanChoice[jabatan] = selectedJabatan.contains(jabatan);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Jabatan",
              choice: jabatanChoice,
            );
          },
        );

        if (result != null) {
          final selected = <String>[];
          result.forEach((key, isSelected) {
            if (isSelected) selected.add(key);
          });

          setState(() {
            selectedJabatan = selected;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selectedJabatan.isEmpty
              ? Colors.transparent
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedJabatan.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Text(
              selectedJabatan.isEmpty
                  ? 'Jabatan'
                  : selectedJabatan.length == 1
                      ? selectedJabatan.first
                      : '${selectedJabatan.length} Jabatan',
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_sharp),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilter(ReportDashboardViewmodel vm) {
    // Gunakan cached status list agar tidak hilang saat loading
    final statusList = widget.isPresent ? vm.presentStatusList : vm.absentStatusList;

    if (statusList.isEmpty) {
      return InkWell(
        onTap: null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            children: [
              Text('Status', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () async {
        if (statusList.isEmpty) return;

        final Map<String, bool> statusChoice = {};
        for (var status in statusList) {
          statusChoice[status.text] = vm.selectedStatusIds.contains(status.status);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Status Absensi",
              choice: statusChoice,
            );
          },
        );

        if (result != null) {
          final selectedIds = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final status = statusList.firstWhere(
                (s) => s.text == key,
                orElse: () => StatusAbsensi(status: 0, text: ''),
              );
              if (status.status != 0) selectedIds.add(status.status);
            }
          });
          vm.updateStatusFilter(selectedIds);
          _loadData();
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedStatusIds.isEmpty
              ? Colors.transparent
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: vm.selectedStatusIds.isEmpty
                ? Colors.grey.shade300
                : Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedStatusText,
              style: TextStyle(
                color: vm.selectedStatusIds.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedStatusIds.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedStatusIds.isNotEmpty
                  ? Colors.blue.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ReportDashboardViewmodel vm) {
    final result =
        widget.isPresent ? vm.presentDetailResult : vm.absentDetailResult;

    if (result.isInitialOrLoading) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingEmployeeActivity(),
      );
    }

    if (result.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Gagal memuat data'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadData,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    final data = result.dataOrNull;
    final list = data?.data ?? [];

    final filteredList = list.where((employee) {
      final matchSearch = searchQuery.isEmpty ||
          employee.nama.toLowerCase().contains(searchQuery) ||
          employee.idPegawai.toLowerCase().contains(searchQuery);

      final matchJabatan =
          selectedJabatan.isEmpty || selectedJabatan.contains(employee.jabatan);

      return matchSearch && matchJabatan;
    }).toList();

    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          searchQuery.isNotEmpty || selectedJabatan.isNotEmpty
              ? 'Tidak ada karyawan yang sesuai filter'
              : 'Tidak ada data karyawan',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return _buildEmployeeCard(
          filteredList[index],
          index,
        );
      },
    );
  }

  Widget _buildEmployeeCard(
    AttendanceDetail employee,
    int index,
  ) {
    final code = 'KRY-${(index + 1).toString().padLeft(3, '0')}';
    final List<String> statusList =
        employee.status!.split('&').map((e) => e.trim().toUpperCase()).toList();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade700,
                backgroundImage: employee.foto.isNotEmpty
                    ? NetworkImage(employee.foto)
                    : null,
                child: employee.foto.isEmpty
                    ? Text(
                        employee.nama.initialName(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.nama,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      '${employee.idPegawai} • ${employee.jabatan}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code, // ✅ KRY-001, KRY-002, dst
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 90,
                  ),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // Rounded corners
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.timelapse,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                "Clocked Time",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(employee.jamKeluar?.toHourSafe() ?? 'N/A',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12.sp)),
                              Text('-',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12.sp)),
                              Text(employee.jamKeluar?.toHourSafe() ?? 'N/A',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12.sp)),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: employee.status!
                              .split('&')
                              .map((e) => e.trim().toUpperCase())
                              .map(
                                (status) => Container(
                                  height: 20.h,
                                  width: 20.w,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 90,
                  ),
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // Rounded corners
                    border: Border.all(
                        color: Colors.grey.shade300), // Light grey border
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.navigation_outlined,
                            size: 20.sp,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            "Site Kerja",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        textAlign: TextAlign.center,
                        employee.namaSite,
                        style:
                            TextStyle(color: Colors.black87, fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('hadir')) {
      return Colors.green;
    } else if (status.toLowerCase().contains('terlambat') ||
        status.contains('t')) {
      return Colors.orange;
    } else if (status.toLowerCase().contains('diluar') ||
        status.contains('?')) {
      return Colors.amber.shade700;
    } else if (status.toLowerCase().contains('alpha') ||
        status.toLowerCase().contains('absen')) {
      return Colors.red;
    } else if (status.toLowerCase().contains('izin')) {
      return Colors.blue;
    } else if (status.toLowerCase().contains('sakit')) {
      return Colors.purple;
    } else if (status.toLowerCase().contains('cuti')) {
      return Colors.teal;
    }
    return Colors.grey;
  }

  Future<void> _selectDate(
      BuildContext context, ReportDashboardViewmodel vm) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: vm.selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2999),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade700,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != vm.selectedDate) {
      vm.changeDate(picked);
      _loadData();
    }
  }
}
