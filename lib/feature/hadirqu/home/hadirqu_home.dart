import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/feature/routes/hadirqu_routes.dart';

class HadirQuHome extends StatefulWidget {
  const HadirQuHome({super.key});

  @override
  State<HadirQuHome> createState() => _HadirQuHomeState();
}

class _HadirQuHomeState extends State<HadirQuHome>
    with SingleTickerProviderStateMixin {
  late int currentTab;
  late TabController tabController;

  @override
  void initState() {
    currentTab = 1;
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentTab && mounted) {
        changePage(value);
      }
    });
    super.initState();
  }

  void changePage(int newTab) {
    setState(() {
      currentTab = newTab;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Kehadiran',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue.shade700,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Rekap Absensi Hari Ini',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDateCard(DateTime.now().eeeedMMMyyyyHHmm(dateDelimiter:' ')),
                        const SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 4 / 2,
                            ),
                            children: [
                              _buildStatisticCard('32 / 40', 'Karyawan Hadir'),
                              _buildStatisticCard('10', 'Karyawan Lembur'),
                              _buildStatisticCard('8', 'Karyawan Izin/Cuti'),
                              _buildStatisticCard('2', 'Aktivitas Karyawan'),
                            ],
                          ),
                        ),
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
                                image: AppAssets.icListKaryawan,
                                title: 'List Karyawan',
                                onTap: () => context.pushNamed(
                                    HadirQuRoutes.listEmployee.name!)),
                            _buildQuickActionButton(
                              image: AppAssets.icReportDashboard,
                              title: 'Report Dashboard',
                              onTap: () => context.pushNamed(
                                  HadirQuRoutes.reportDashboard.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icPresensiKaryawan,
                              title: 'Presensi Karyawan',
                              onTap: () => context.pushNamed(
                                  HadirQuRoutes.reportPresence.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icPresensiKaryawan,
                              title: 'Log Presensi',
                              onTap: () => context.pushNamed(
                                  HadirQuRoutes.logPresence.name!),
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icIzinKaryawan,
                              title: 'Izin Karyawan',
                                onTap: () => context.pushNamed(
                                    HadirQuRoutes.permission.name!)
                            ),
                            _buildQuickActionButton(
                              image: AppAssets.icLemburKaryawan,
                              title: 'Lembur Karyawan',
                              onTap: () => context.pushNamed(
                                  HadirQuRoutes.overTimeSubmission.name!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pengajuan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    controller: tabController,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue.shade700,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Izin'),
                      Tab(text: 'Cuti'),
                      Tab(text: 'Lembur'),
                    ],
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 200, maxHeight: 450),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        _buildTabContent('Izin', 2),
                        _buildTabContent('Cuti', 1),
                        _buildTabContent('Lembur', 1),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String type, int count) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hari Ini',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8),
          _buildRequestCard(),
          SizedBox(height: 8),
          _buildRequestCard(),
        ],
      ),
    );
  }

  Widget _buildDateCard(String date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, color: Color(0Xff04297A)),
          SizedBox(width: 8),
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0Xff04297A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
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
      color: Colors.blue.shade700,
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
                  backgroundColor: Color(0XFF2758A7),
                  child: SvgPicture.asset(
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

  Widget _buildRequestCard() {
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
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Justinus William',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'justinuswilliam • KRY-001',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.amber.shade700,
                        size: 14,
                      ),
                      SizedBox(width: 2),
                      const Flexible(
                        child: Text(
                          'Menunggu',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
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
              padding: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
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
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pengajuan Izin',
                        style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.calendar_today, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Waktu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  SizedBox(height: 4),
                                  Text(
                                    '23 Des 2024',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.access_time, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Durasi',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ]),
                                  SizedBox(height: 4),
                                  Text(
                                    '1 Hari',
                                    style: TextStyle(
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
                          Row(children: [
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
                          const Text(
                            'Menyelesaikan sisa design yang belum kelar',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          // Attachment
                          Row(children: [
                            Icon(
                              Icons.description_rounded,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Keterangan',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.image, color: Colors.grey.shade600),
                              const SizedBox(width: 8),
                              const Text(
                                'image-232123.jpg',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
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
