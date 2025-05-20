import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:shelter_super_app/feature/routes/guard_routes.dart';
import 'package:shelter_super_app/feature/routes/issuequ_routes.dart';

class IssueQuHome extends StatelessWidget {
  const IssueQuHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> indicatorColors = [
      Colors.red,
      Colors.blue.shade900,
      Colors.blue,
      Colors.blue.shade100,
      Colors.green,
      Colors.orange,
    ];

    // Define the report data
    final List<Map<String, dynamic>> reportItems = [
      {'title': 'Total Laporan', 'value': 13},
      {'title': 'Total Menunggu', 'value': 12},
      {'title': 'Total Sedang Dikerjakan', 'value': 7},
      {'title': 'Total Menunggu Approval', 'value': 280},
      {'title': 'Total Selesai', 'value': 280},
      {'title': 'Total Ditolak', 'value': 280},
    ];

    return Scaffold(
      backgroundColor: Color(0XFF154B79),
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Dashboard IssueQu',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0XFF154B79),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0XFF154B79),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        _buildDateCard(DateTime.now()
                            .eeeedMMMyyyyHHmm(dateDelimiter: ' ')),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildQuickActionButton(
                              image: AppAssets.icAktivitas,
                              title: 'Laporan MoM',
                              onTap: () => context.pushNamed(
                                  IssueQuRoutes.mom.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icTerjadwal,
                              title: 'Kelola Keluhan',
                              onTap: () => context
                                  .pushNamed(IssueQuRoutes.keluhan.name!),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade100,
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: 600.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Statistik',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: DoubleDateWidget(
                              theme: ThemeWidget.darkBlue,
                              endDate: DateTime.now().ddMMyyyy('/'),
                              startDate: DateTime.now().ddMMyyyy('/'),
                              onChangeStartDate: (date) {},
                              onChangeEndDate: (date) {},
                            ),
                          ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: reportItems.mapIndexed((index, item) {
                            final isFirst = index == 0;
                            final isLast = index == reportItems.length - 1;

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Colored Indicator
                                Container(
                                  width: 6,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: indicatorColors[index],
                                    borderRadius: BorderRadius.vertical(
                                      top: isFirst ? const Radius.circular(12) : Radius.zero,
                                      bottom: isLast ? const Radius.circular(12) : Radius.zero,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Content
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          item['value'].toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(String date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, color: Color(0XFF154B79)),
          const SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0XFF154B79),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    String image = '',
    String title = '',
    Function? onTap,
  }) {
    return Material(
      color: Color(0XFF154B79),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          width: 85.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade800,
                  child: image.contains('svg')
                      ? SvgPicture.asset(
                          image,
                          width: 24,
                          height: 24,
                        )
                      : Image.asset(
                          image,
                          width: 24,
                          height: 24,
                        )),
              SizedBox(height: 12.h),
              Text(
                textAlign: TextAlign.center,
                title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
