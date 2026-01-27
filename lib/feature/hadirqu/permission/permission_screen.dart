import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/loading_list_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/data/model/hadirqu_leave_report_response.dart';
import '../../../core/platform/permission/permission_service.dart';
import '../../../core/utils/common.dart';
import '../../../design/default_snackbar.dart';
import '../../../design/show_image.dart';
import 'viewmodel/permission_viewmodel.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PermissionViewmodel()..init(),
      child: const _PermissionView(),
    );
  }
}

class _PermissionView extends StatefulWidget {
  const _PermissionView();

  @override
  State<_PermissionView> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<_PermissionView> {
  final permissionService = PermissionServiceImpl();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PermissionViewmodel>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Izin Karyawan",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _calendarHeader(vm),
            _filter(vm),
            Expanded(
              child: _buildContent(vm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(PermissionViewmodel vm) {
    if (vm.isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingListShimmer(),
      );
    }

    if (vm.isError) {
      return const Center(child: Text('Gagal memuat data'));
    }

    if (vm.leaveList.isEmpty) {
      return const Center(child: Text('Tidak ada data izin'));
    }

    return ListView.builder(
      itemCount: vm.leaveList.length,
      itemBuilder: (_, index) => _card(vm.leaveList[index]),
    );
  }

  Widget _calendarHeader(PermissionViewmodel vm) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            vm.selectedDate.add(const Duration(days: -1)),
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
              Expanded(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: vm.isLoading ? null : () => _selectDate(context, vm),
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
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
              const SizedBox(width: 2),
              Material(
                color: Colors.white,
                child: InkWell(
                  onTap: vm.isLoading
                      ? null
                      : () {
                          vm.changeDate(
                            vm.selectedDate.add(const Duration(days: 1)),
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
    );
  }

  Widget _filter(PermissionViewmodel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildDepartemenFilter(PermissionViewmodel vm) {
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
                orElse: () => LeaveDepartemen(
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
            color:
                vm.selectedDepartemenIds.isEmpty ? Colors.black38 : Colors.blue,
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

  Widget _buildStatusFilter(PermissionViewmodel vm) {
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
                orElse: () => LeaveStatus(id: 0, nama: ''),
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
            color: vm.selectedStatus.isEmpty ? Colors.black38 : Colors.blue,
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

  Widget _card(LeaveReport leave) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  radius: 24.0,
                  backgroundColor: Colors.blue.shade700,
                  backgroundImage: leave.pemohon.foto.isNotEmpty
                      ? NetworkImage(leave.pemohon.foto)
                      : null,
                  child: leave.pemohon.foto.isEmpty
                      ? Text(
                          leave.pemohon.nama.initialName(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leave.pemohon.nama,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${leave.pemohon.idPegawai ?? "-"} • ${leave.site.nama}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                _buildStatusBadge(leave.status),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: _getJenisColor(leave.jenisCuti.id).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2.0,
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
                        decoration: BoxDecoration(
                          color: _getJenisColor(leave.jenisCuti.id),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getJenisText(leave.jenisCuti.id),
                        style: TextStyle(
                          color: _getJenisColor(leave.jenisCuti.id),
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Waktu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  leave.waktu,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.access_time, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Durasi',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${leave.durasi} hari',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        // Description
                        const Row(
                          children: [
                            Icon(Icons.density_medium, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Keterangan',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          leave.keterangan,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const Row(
                          children: [
                            Icon(Icons.description_rounded, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Lampiran',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (leave.file.ext != null)
                          Row(
                            children: [
                              Icon(Icons.image, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'file.${leave.file.ext}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (leave.file.path != "") {
                                    saveToGallery(leave.file.path).then((data) {
                                      showDefaultSuccessShowFile(
                                          context, "Gambar berhasil disimpan",
                                          () {
                                        showImage(context, data['filePath']);
                                      });
                                    });
                                  } else if (leave.file != "") {
                                    saveToGallery(leave.file.toString());
                                  } else {
                                    showDefaultError(context,
                                        "Bukti download tidak ditemukan");
                                  }
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        else
                          const Text(
                            'Tidak ada lampiran',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;
    String label; // 👈 text yang ditampilkan

    switch (status.toLowerCase()) {
      case 'disetujui':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        icon = Icons.check_circle;
        label = 'Disetujui';
        break;

      case 'ditolak':
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        icon = Icons.cancel;
        label = 'Ditolak';
        break;

      case 'menunggu persetujuan':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        icon = Icons.access_time;
        label = 'Menunggu'; // ✅ dipendekkan
        break;

      case 'sedang berlangsung':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        icon = Icons.play_circle;
        label = 'Berlangsung'; // ✅ dipendekkan
        break;

      default:
        bgColor = Colors.grey.shade50;
        textColor = Colors.grey.shade700;
        icon = Icons.info;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 14),
          const SizedBox(width: 4),
          Text(
            label, // 👈 pakai label
            style: TextStyle(
              fontSize: 10,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getJenisColor(String jenisId) {
    switch (jenisId.toLowerCase()) {
      case 'cuti':
        return Colors.purple.shade900;
      case 'izin':
        return Colors.orange.shade900;
      case 'sakit':
        return Colors.red.shade900;
      default:
        return Colors.blue.shade900;
    }
  }

  String _getJenisText(String jenisId) {
    switch (jenisId.toLowerCase()) {
      case 'cuti':
        return 'Pengajuan Cuti';
      case 'izin':
        return 'Pengajuan Izin';
      case 'sakit':
        return 'Pengajuan Sakit';
      default:
        return 'Pengajuan Lainnya';
    }
  }

  Future<void> _selectDate(
    BuildContext context,
    PermissionViewmodel vm,
  ) async {
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
    }
  }
}
