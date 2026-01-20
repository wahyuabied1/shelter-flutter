import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';

import '../../../../data/model/hadirqu_presence_list_response.dart';
import '../attendance_sheet.dart';
import '../viewmodel/contract/presence_detail_contract.dart';

class EmployeeCard extends StatefulWidget {
  final PresenceData employee;
  final PresenceDetailContract vm;

  const EmployeeCard({
    required this.employee,
    required this.vm,
  });

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool _isLoadingDetail = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                radius: 20.0,
                child: Text(
                  widget.employee.karyawan.nama.initialName(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.employee.karyawan.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.employee.karyawan.idPegawai} • ${widget.employee.karyawan.jabatan}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  '${widget.employee.karyawan.id}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Presence Summary
          const Text(
            'Rangkuman Presensi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),

          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.employee.presensi.entries.map((entry) {
              Color bgColor = Colors.grey[100]!;

              if (entry.key.toLowerCase().contains('hadir')) {
                bgColor = Colors.green[100]!;
              } else if (entry.key.toLowerCase().contains('terlambat')) {
                bgColor = Colors.orange[100]!;
              } else if (entry.key.toLowerCase().contains('absen')) {
                bgColor = Colors.red[100]!;
              } else if (entry.key.toLowerCase().contains('diluar') ||
                  entry.key.toLowerCase().contains('lokasi')) {
                bgColor = Colors.orange[100]!;
              } else if (entry.key.toLowerCase().contains('izin') ||
                  entry.key.toLowerCase().contains('sakit')) {
                bgColor = Colors.blue[100]!;
              } else if (entry.key.toLowerCase().contains('cuti')) {
                bgColor = Colors.purple[100]!;
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text('${entry.value}'),
                  ),
                  const SizedBox(width: 4.0),
                  Text(entry.key),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 16.0),

          // Detail Link
          Center(
            child: TextButton(
              onPressed: _isLoadingDetail
                  ? null
                  : () async {
                      setState(() {
                        _isLoadingDetail = true;
                      });

                      try {
                        // Fetch detail
                        final success = await widget.vm.getPresenceDetail(
                          widget.employee.karyawan.id,
                        );

                        if (!success && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Gagal memuat detail presensi'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (mounted &&
                            widget.vm.presenceDetailResult.dataOrNull != null) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (_) => AttendanceSheet(
                              name: widget.employee.karyawan.nama,
                              role: widget.employee.karyawan.jabatan,
                              id: widget.employee.karyawan.idPegawai,
                              imageUrl: '',
                              presenceDetail:
                                  widget.vm.presenceDetailResult.dataOrNull,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoadingDetail = false;
                          });
                        }
                      }
                    },
              child: _isLoadingDetail
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      'Lihat Detail ▼',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
