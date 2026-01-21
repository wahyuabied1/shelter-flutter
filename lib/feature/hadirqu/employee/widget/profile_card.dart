import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/data/model/hadirqu_employee_list_response.dart';

class ProfileCard extends StatefulWidget {
  final Employee employee;
  final int index;

  const ProfileCard({
    super.key,
    required this.employee,
    required this.index,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final employee = widget.employee;
    final code = 'KRY-${(widget.index + 1).toString().padLeft(3, '0')}';

    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(8.w),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// AVATAR
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.blue.shade700,
                      backgroundImage: employee.foto.isNotEmpty
                          ? NetworkImage(employee.foto)
                          : null,
                      child: employee.foto.isEmpty
                          ? Text(
                              employee.nama.initialName(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            )
                          : null,
                    ),

                    SizedBox(width: 12.w),

                    /// DATA
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.nama,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            width: 220.w,
                            child: Table(
                              children: [
                                _row(employee.nama, '· $code'),
                                _row(
                                  "Departemen",
                                  ": ${employee.namaDepartemen ?? '-'}",
                                ),
                                _row(
                                  "Jabatan",
                                  ": ${employee.jabatan ?? '-'}",
                                ),
                                _row(
                                  "Grup/Template",
                                  ": ${employee.grup ?? '-'}",
                                ),
                                _row(
                                  "Site",
                                  ": ${employee.namaSite ?? '-'}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /// EXPANDED CONTENT
            children: [
              if (employee.jadwal != null)
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal: ${employee.jadwal!.nama}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        children: [
                          TableRow(
                            children: [
                              _tableHeader("Hari"),
                              _tableHeader("Jam"),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  employee.jadwal!.detail?.hari?.join(', ') ??
                                      '-',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kerja: ${employee.jadwal!.detail?.jamMulai ?? '-'} - ${employee.jadwal!.detail?.jamSelesai ?? '-'}',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Istirahat: ${employee.jadwal!.detail?.jamIstirahat ?? '-'} - ${employee.jadwal!.detail?.jamIstirahatSelesai ?? '-'}',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Text(
                    'Tidak ada jadwal',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// REUSABLE ROW
  TableRow _row(String left, String right) {
    return TableRow(
      children: [
        Text(
          left,
          style: TextStyle(fontSize: 12.sp),
        ),
        Text(
          right,
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
