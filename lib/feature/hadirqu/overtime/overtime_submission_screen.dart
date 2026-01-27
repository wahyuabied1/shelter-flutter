import 'package:alice/utils/alice_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/loading_line_shimmer.dart';
import 'package:shelter_super_app/design/multi_choice_bottom_sheet.dart';
import 'package:shelter_super_app/design/overtime_header.dart';
import 'package:shelter_super_app/data/model/hadirqu_overtime_submission_response.dart';
import 'package:shelter_super_app/feature/hadirqu/overtime/viewmodel/overtime_submission_viewmodel.dart';
import '../../../core/platform/permission/permission_service.dart';
import '../../../core/utils/common.dart';
import '../../../design/default_snackbar.dart';
import '../../../design/loading_list_shimmer.dart';
import '../../../design/show_image.dart';
import '../../../design/theme_widget.dart';
import 'package:intl/intl.dart';

class OverTimeSubmissionScreen extends StatelessWidget {
  const OverTimeSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OvertimeSubmissionViewmodel()..init(),
      child: const _OverTimeSubmissionView(),
    );
  }
}

class _OverTimeSubmissionView extends StatefulWidget {
  const _OverTimeSubmissionView();

  @override
  State<_OverTimeSubmissionView> createState() =>
      _OverTimeSubmissionScreenState();
}

class _OverTimeSubmissionScreenState extends State<_OverTimeSubmissionView> {
  final permissionService = PermissionServiceImpl();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OvertimeSubmissionViewmodel>();

    return Container(
      color: ThemeWidget.greyBackground.colorTheme(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverTimeHeader(
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
            onChangeSearch: (searchKey) {
              vm.updateSearchQuery(searchKey);
            },
          ),
          _filter(vm),
          if (vm.isLoading)
            const LoadingLineShimmer(
              marginHorizontal: true,
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Menampilkan ${vm.totalData} Data',
                style: TextStyle(color: Colors.black54, fontSize: 12.sp),
              ),
            ),
          Expanded(child: _buildContent(vm)),
        ],
      ),
    );
  }

  Widget _buildContent(OvertimeSubmissionViewmodel vm) {
    if (vm.isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingListShimmer(),
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
              onPressed: vm.getOvertimeSubmission,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (vm.submissionList.isEmpty) {
      return Center(
        child: Text(
          vm.searchQuery.isNotEmpty ||
                  vm.selectedDepartemenIds.isNotEmpty ||
                  vm.selectedStatus.isNotEmpty
              ? 'Tidak ada data yang sesuai filter'
              : 'Tidak ada data lembur',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.submissionList.length,
      itemBuilder: (context, index) {
        return _card(vm, vm.submissionList[index], index);
      },
    );
  }

  Widget _filter(OvertimeSubmissionViewmodel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16),
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

  Widget _buildDepartemenFilter(OvertimeSubmissionViewmodel vm) {
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
                orElse: () => OvertimeSubmissionDepartemen(
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

  Widget _buildStatusFilter(OvertimeSubmissionViewmodel vm) {
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
                orElse: () => OvertimeSubmissionStatus(id: 0, nama: ''),
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
                fontSize: 12.sp,
                color: vm.selectedStatus.isNotEmpty
                    ? Colors.blue.shade700
                    : Colors.black,
                fontWeight: vm.selectedStatus.isNotEmpty
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            SizedBox(width: 4.w),
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

  Widget _card(
    OvertimeSubmissionViewmodel vm,
    OvertimeSubmission submission,
    int index,
  ) {
    final code = 'KRY-${(index + 1).toString().padLeft(3, '0')}';

    return Card(
      elevation: 0,
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
                  backgroundImage: submission.pemohon.foto != null &&
                          submission.pemohon.foto!.isNotEmpty
                      ? NetworkImage(submission.pemohon.foto!)
                      : null,
                  child: submission.pemohon.foto == null ||
                          submission.pemohon.foto!.isEmpty
                      ? Text(
                          submission.pemohon.nama.initialName(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submission.pemohon.nama,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${submission.pemohon.idPegawai ?? "-"} • $code',
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(submission.status),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
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
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pengajuan Lembur',
                        style: TextStyle(
                          color: Colors.blue.shade700,
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
                                      'Tanggal & Waktu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${submission.tanggal}\n${submission.waktu}',
                                  style: const TextStyle(
                                    fontSize: 12,
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
                                  submission.durasi,
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

                        // Bukti Mulai
                        if (submission.berkas.isNotEmpty &&
                            submission.berkas.first.mulai != null) ...[
                          _buildAttachmentSection(
                            vm,
                            'Bukti Mulai',
                            submission.berkas.first.mulai!,
                            submission.location.mulai,
                          ),
                          SizedBox(height: 12.h),
                        ],

                        // Bukti Selesai
                        if (submission.berkas.isNotEmpty &&
                            submission.berkas.first.selesai != null) ...[
                          _buildAttachmentSection(
                            vm,
                            'Bukti Selesai',
                            submission.berkas.first.selesai!,
                            submission.location.selesai,
                          ),
                          SizedBox(height: 12.h),
                        ],

                        // Keterangan
                        Row(
                          children: [
                            Icon(Icons.density_medium, size: 14.sp),
                            const SizedBox(width: 4),
                            Text(
                              'Keterangan',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          submission.keterangan,
                          style: TextStyle(fontSize: 14.sp),
                        ),

                        // Reviewer Note (jika ada)
                        if (submission.reviewer != null &&
                            submission.reviewer!.note != null) ...[
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, size: 14.sp),
                              const SizedBox(width: 4),
                              Text(
                                'Catatan Reviewer',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            submission.reviewer!.note!,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
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

  Widget _buildAttachmentSection(
    OvertimeSubmissionViewmodel vm,
    String title,
    String fileUrl,
    LocationPoint location,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.description_rounded,
              size: 16.sp,
              color: AliceConstants.grey,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AliceConstants.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xffE8E8E8)),
          ),
          child: Row(
            children: [
              Icon(Icons.image, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fileUrl.split('/').last,
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (fileUrl != "") {
                    saveToGallery(fileUrl).then((data) {
                      showDefaultSuccessShowFile(
                          context, "Gambar berhasil disimpan", () {
                        showImage(context, data['filePath']);
                      });
                    });
                  } else if (fileUrl != "") {
                    saveToGallery(fileUrl.toString());
                  } else {
                    showDefaultError(context, "Bukti download tidak ditemukan");
                  }
                },
                icon: const Icon(Icons.download, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        FutureBuilder<String>(
          future: vm.getAddress(location.lat, location.long),
          builder: (context, snapshot) {
            return Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AliceConstants.grey,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    snapshot.hasData
                        ? 'Absen dari: ${snapshot.data}'
                        : 'Memuat alamat...',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AliceConstants.grey,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'disetujui':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        icon = Icons.check_circle;
        break;
      case 'ditolak':
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        icon = Icons.cancel;
        break;
      case 'menunggu persetujuan':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        icon = Icons.access_time;
        break;
      case 'sedang berlangsung':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        icon = Icons.play_circle;
        break;
      default:
        bgColor = Colors.black12;
        textColor = Colors.black54;
        icon = Icons.access_time;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 12.sp),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 12.sp),
          SizedBox(width: 2.w),
          Text(
            status,
            style: TextStyle(fontSize: 10.sp, color: textColor),
          ),
        ],
      ),
    );
  }
}
