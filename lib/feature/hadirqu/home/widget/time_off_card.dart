import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/basic_extensions/number_extensions.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/utils/common.dart';
import 'package:shelter_super_app/data/model/time_off_response.dart';
import 'package:shelter_super_app/design/default_snackbar.dart';
import 'package:shelter_super_app/design/show_image.dart';

class TimeOffCard extends StatelessWidget {
  final TimeOffResponse timeOffResponse;
  final String title;

  const TimeOffCard(
      {super.key, required this.timeOffResponse, required this.title});

  Color getThemeColor() {
    if (title.contains("Lembur") ?? false) {
      return Colors.blue.shade700;
    } else if (title.contains("Cuti") ?? false) {
      return Colors.amber.shade700;
    } else {
      return Colors.red.shade700;
    }
  }

  Color getBgThemeColor() {
    if (title.contains("Lembur") ?? false) {
      return Colors.blue.shade50;
    } else if (title.contains("Cuti") ?? false) {
      return Colors.amber.shade50;
    } else {
      return Colors.red.shade50;
    }
  }

  Color getTextColor() {
    if (timeOffResponse.status?.contains("Disetujui") ?? false) {
      return Colors.green.shade700;
    } else if (timeOffResponse.status?.contains("Menunggu") ?? false) {
      return Colors.orange.shade700;
    } else {
      return Colors.red.shade700;
    }
  }

  Color getBgColor() {
    if (timeOffResponse.status?.contains("Disetujui") ?? false) {
      return Colors.green.shade50;
    } else if (timeOffResponse.status?.contains("Menunggu") ?? false) {
      return Colors.orange.shade50;
    } else {
      return Colors.red.shade50;
    }
  }

  String getStatus() {
    if (timeOffResponse.status?.contains("Disetujui") ?? false) {
      return "Disetujui";
    } else if (timeOffResponse.status?.contains("Menunggu") ?? false) {
      return "Menunggu";
    } else {
      return "Ditolak";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: (timeOffResponse.pemohon?.foto == null ||
                          timeOffResponse.pemohon?.foto == "")
                      ? const Icon(Icons.person, color: Colors.grey)
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  NetworkImage(timeOffResponse.pemohon!.foto!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeOffResponse.pemohon?.nama ?? "",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${timeOffResponse.pemohon?.nama.initialName()}-${timeOffResponse.pemohon?.idPegawai}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 90.w,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getBgColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: getTextColor(),
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          getStatus(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: getTextColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: getBgThemeColor(),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade200, // Border color
                  width: 2.0, // Border width
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
                          color: getThemeColor(),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pengajuan ${title}',
                        style: TextStyle(
                            color: getThemeColor(),
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(children: [
                                    Icon(Icons.calendar_today, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Waktu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  const SizedBox(height: 4),
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 150,
                                    ),
                                    child: Text(
                                      timeOffResponse.waktu ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(children: [
                                    Icon(Icons.access_time, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Durasi',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${timeOffResponse.durasi.orEmpty} Hari',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          // Description
                          const Row(children: [
                            Icon(
                              Icons.density_medium,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Keterangan',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                          const SizedBox(height: 4),
                          Text(
                            timeOffResponse.keterangan ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          // Attachment
                          const Row(children: [
                            Icon(
                              Icons.description_rounded,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Bukti',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.image, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              const Text(
                                'Download bukti gambar',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  if (timeOffResponse.file?.path != null &&
                                      timeOffResponse.file?.path != "") {
                                    saveToGallery(timeOffResponse.file!.path!)
                                        .then((data) {
                                      showDefaultSuccessShowFile(
                                          context, "Gambar berhasil disimpan",
                                          () {
                                        showImage(context, data['filePath']);
                                      });
                                    });
                                  } else if (timeOffResponse
                                              .berkas?.firstOrNull !=
                                          null &&
                                      timeOffResponse.berkas?.firstOrNull !=
                                          "") {
                                    saveToGallery(
                                        timeOffResponse.berkas!.firstOrNull!);
                                  } else {
                                    showDefaultError(context,
                                        "Bukti download tidak ditemukan");
                                  }
                                },
                                icon: const Icon(Icons.download,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
          // Details section
        ],
      ),
    );
  }
}
