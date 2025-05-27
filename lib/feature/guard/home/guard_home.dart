import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';
import 'package:shelter_super_app/design/theme_widget.dart';
import 'package:shelter_super_app/feature/routes/guard_routes.dart';

class GuardHome extends StatelessWidget {
  const GuardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Dashboard Shelter Guard',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.red.shade700,
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
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Rekap Guard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                              title: 'Rekap Checklist',
                              onTap: () => context.pushNamed(
                                  GuardRoutes.checklistRecap.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icTerjadwal,
                              title: 'Temuan Patrol',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.patrolFinding.name!),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Rekap Posko',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                              image: AppAssets.icTransporter,
                              title: 'Trans\nporter',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.transporter.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icKey,
                              title: 'Pinjaman Kunci',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.pinjamanKunci.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icPresensiKaryawan,
                              title: 'Tamu\n',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.guest.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icMail,
                              title: 'Surat\n',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.mail.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icProyek,
                              title: 'Proyek\n',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.project.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icTelp,
                              title: 'Pemakaian Telpon',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.pemakaianTelp.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icNewspaper,
                              title: 'Berita Acara',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.news.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icJournal,
                              title: 'Jurnal Harian',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.dailyJournal.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icCar,
                              title: 'Kendaraan\n',
                              onTap: () => context
                                  .pushNamed(GuardRoutes.kendaraan.name!),
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
                              theme: ThemeWidget.red,
                              endDate: DateTime.now().ddMMyyyy('/'),
                              startDate: DateTime.now().ddMMyyyy('/'),
                              onChangeStartDate: (date) {},
                              onChangeEndDate: (date) {},
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GridView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                              ),
                              children: [
                                _buildStatisticCard('13', 'Total Petugas', 1),
                                _buildStatisticCard('12', 'Total Absensi', 2),
                                _buildStatisticCard('7', 'Total Rekap Checklist', 3),
                                _buildStatisticCard(
                                    '28', 'Total Temuan Patroli', 4),
                              ],
                            ),
                          )
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

  Widget _buildStatisticCard(String value, String label, int number) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          left: (number == 2 || number == 4)
              ? BorderSide(color: Colors.grey, width: 0.2)
              : BorderSide(color: Colors.transparent),
          right: (number == 1 || number == 3)
              ? BorderSide(color: Colors.grey, width: 0.2)
              : BorderSide(color: Colors.transparent),
          bottom: (number == 1 || number == 2)
              ? BorderSide(color: Colors.grey, width: 0.2)
              : BorderSide(color: Colors.transparent),
          top: (number == 3 || number == 4)
              ? BorderSide(color: Colors.grey, width: 0.2)
              : BorderSide(color: Colors.transparent),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
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
          Icon(Icons.calendar_today, color: Colors.red.shade900),
          const SizedBox(width: 8),
          Text(
            date,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.red.shade900,
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
      color: Colors.red.shade700,
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
                  backgroundColor: Colors.red.shade500,
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
