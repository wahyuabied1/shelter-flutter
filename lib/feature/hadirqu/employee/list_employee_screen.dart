import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/data/model/hadirqu_employee_list_response.dart';
import 'package:shelter_super_app/feature/hadirqu/employee/viewmodel/list_employee_viewmodel.dart';
import 'package:shelter_super_app/feature/hadirqu/employee/widget/profile_card.dart';

import '../../../design/loading_line_shimmer.dart';
import '../../../design/loading_list_shimmer.dart';

class ListEmployeeScreen extends StatelessWidget {
  const ListEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListEmployeeViewmodel()..init(),
      child: const _ListEmployeeView(),
    );
  }
}

class _ListEmployeeView extends StatefulWidget {
  const _ListEmployeeView();

  @override
  State<_ListEmployeeView> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<_ListEmployeeView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ListEmployeeViewmodel>();

    return Scaffold(
      backgroundColor: const Color(0XFFF3F5F6),
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "List Karyawan",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search Field
            TextField(
              onChanged: (value) => vm.updateSearchQuery(value),
              cursorColor: Colors.blue[800],
              decoration: InputDecoration(
                hintText: 'Cari karyawan',
                hintStyle: const TextStyle(color: Colors.black12),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1, color: Colors.black12),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1, color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDepartemenFilter(vm),
                  SizedBox(width: 12.w),
                  _buildJabatanFilter(vm),
                  SizedBox(width: 12.w),
                  _buildGrupFilter(vm),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Employee Count
            if (vm.isLoading)
              const LoadingLineShimmer()
            else
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menampilkan ${vm.totalEmployees} Karyawan',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 8),

            // Employee List
            Expanded(
              child: _buildContent(vm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartemenFilter(ListEmployeeViewmodel vm) {
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
                orElse: () => EmployeeDepartemen(
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

  Widget _buildJabatanFilter(ListEmployeeViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableJabatan.isEmpty) return;

        final Map<String, bool> jabatanChoice = {};
        for (var jabatan in vm.availableJabatan) {
          jabatanChoice[jabatan] = vm.selectedJabatan.contains(jabatan);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
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
          vm.updateJabatanFilter(selected);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedJabatan.isEmpty
              ? Colors.transparent
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                vm.selectedJabatan.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedJabatanText,
              style: TextStyle(
                color: vm.selectedJabatan.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedJabatan.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedJabatan.isNotEmpty
                  ? Colors.blue.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrupFilter(ListEmployeeViewmodel vm) {
    return InkWell(
      onTap: () async {
        if (vm.availableGrup.isEmpty) return;

        final Map<String, bool> grupChoice = {};
        for (var grup in vm.availableGrup) {
          grupChoice[grup.text] = vm.selectedGrupIds.contains(grup.id);
        }

        final result = await showModalBottomSheet<Map<String, bool>>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return MultiChoiceBottomSheet(
              title: "Group/Template",
              choice: grupChoice,
            );
          },
        );

        if (result != null) {
          final selectedIds = <int>[];
          result.forEach((key, isSelected) {
            if (isSelected) {
              final grup = vm.availableGrup.firstWhere(
                (g) => g.text == key,
                orElse: () => EmployeeGrup(id: 0, text: ''),
              );
              if (grup.id != 0) selectedIds.add(grup.id);
            }
          });
          vm.updateGrupFilter(selectedIds);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: vm.selectedGrupIds.isEmpty
              ? Colors.transparent
              : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                vm.selectedGrupIds.isEmpty ? Colors.grey.shade300 : Colors.blue,
          ),
        ),
        child: Row(
          children: [
            Text(
              vm.selectedGrupText,
              style: TextStyle(
                color: vm.selectedGrupIds.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedGrupIds.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: vm.selectedGrupIds.isNotEmpty
                  ? Colors.blue.shade700
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ListEmployeeViewmodel vm) {
    if (vm.isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingListShimmer(
          marginHorizontal: false,
        ),
      );
    }

    if (vm.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Gagal memuat data'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => vm.getEmployeeList(),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (vm.employeeList.isEmpty) {
      return Center(
        child: Text(
          vm.searchQuery.isNotEmpty ||
                  vm.selectedDepartemenIds.isNotEmpty ||
                  vm.selectedJabatan.isNotEmpty ||
                  vm.selectedGrupIds.isNotEmpty
              ? 'Tidak ada karyawan yang sesuai filter'
              : 'Tidak ada data karyawan',
        ),
      );
    }

    return ListView.builder(
      itemCount: vm.employeeList.length,
      itemBuilder: (context, index) {
        final employee = vm.employeeList[index];
        return ProfileCard(
          employee: employee,
          index: index,
        );
      },
    );
  }
}
