import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/routing/core/bottom_sheet_page.dart';
import 'package:shelter_super_app/data/model/hadirqu_presence_detail_response.dart';

class AttendanceSheet extends StatelessWidget {
  final String name;
  final String role;
  final String id;
  final String imageUrl;
  final HadirquPresenceDetailResponse? presenceDetail;

  const AttendanceSheet({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.imageUrl,
    required this.presenceDetail,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue.shade700,
                      child: Text(
                        _getInitials(name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            role,
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
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        id,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Content
              if (presenceDetail == null || presenceDetail!.data.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('Tidak ada data presensi'),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: presenceDetail!.data.length,
                    itemBuilder: (context, monthIndex) {
                      final month = presenceDetail!.data[monthIndex];
                      return _buildMonthSection(month);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMonthSection(PresenceMonth month) {
    final daysWithData =
        month.detail.where((day) => day.detail.isNotEmpty).toList();

    if (daysWithData.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          color: Colors.blue.shade50,
          child: Text(
            '${month.bulanStr} ${month.tahun}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Column(
          children: daysWithData.asMap().entries.map((entry) {
            final dayIndex = entry.key;
            final day = entry.value;
            final isEven = dayIndex % 2 == 0;

            return Container(
              color: isEven ? Colors.white : Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Column
                  SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day.hari,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          day.tanggal,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Status Column
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: day.detail.map((item) {
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(item.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.kode,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              item.text,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0].substring(0, 1)}${parts[1].substring(0, 1)}'
        .toUpperCase();
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case -1: // Presensi Ditolak
        return Colors.red.shade700;
      case 0: // Absen
        return Colors.red.shade400;
      case 1: // Hadir
        return Colors.green.shade600;
      case 2: // Izin
        return Colors.blue.shade400;
      case 3: // Sakit
        return Colors.purple.shade400;
      case 4: // Terlambat
        return Colors.orange.shade600;
      case 5: // Lembur
        return Colors.indigo.shade400;
      case 6: // Diluar lokasi
        return Colors.amber.shade700;
      case 7: // Diluar lokasi & Terlambat
        return Colors.deepOrange.shade600;
      case 8: // Cuti
        return Colors.teal.shade400;
      case 9: // Pulang Cepat
        return Colors.pink.shade400;
      case 10: // Tidak Clock out
        return Colors.brown.shade400;
      default:
        return Colors.grey.shade600;
    }
  }
}
