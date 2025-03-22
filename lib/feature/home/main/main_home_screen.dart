import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/feature/routes/cleaningqu_routes.dart';
import 'package:shelter_super_app/feature/routes/hadirqu_routes.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  late List<String> _images;

  @override
  void initState() {
    super.initState();
    _images = [
      'assets/images/il_example_ads.jpg',
      'assets/images/il_example_ads.jpg',
      'assets/images/il_example_ads.jpg'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Pagi 👋',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dwisandi Arifin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Statistics Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 3 / 2,
              ),
              children: [
                _buildStatisticCard('7', 'TOTAL KARYAWAN'),
                _buildStatisticCard('8 / 10', 'TIKET KEAMANAN'),
                _buildStatisticCard('13 / 25', 'TIKET KEBERSIHAN'),
                _buildStatisticCard('18 / 20', 'TIKET KELUHAN'),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickActionButton(
                      AppAssets.ilIconHadirqu, 'HadirQu', '(Kehadiran)', () {
                    context.pushNamed(HadirQuRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      AppAssets.ilIconHadirqu, 'CleaningQu', '(Kebersihan)', () {
                    context.pushNamed(CleaningquRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      AppAssets.ilIconIssuequ, 'IssueQu', '(Keluhan)', () {
                    // context.pushNamed(HadirQuRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      AppAssets.ilIconGuard, 'Guard', '(Keamanan)', () {
                    // context.pushNamed(HadirQuRoutes.home.name!);
                  }),
                ],
              ),
            ),
          ),

          // Notifications Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Column(
              children: [
                _buildSectionHeader('Notifikasi', 'Lihat Semua'),
                _buildNotificationItem(
                    'HadirQu',
                    'Pengajuan Cuti dari Agus Hariyono',
                    AppAssets.ilIconIssuequ),
                _buildNotificationItem(
                    'IssueQu',
                    'Keluhan dijawab oleh tim ops Shelter',
                    AppAssets.ilIconHadirqu),

                // Promotions Section
                _buildSectionHeader('Promosi', null),
                Container(
                  child: CarouselSlider(
                    items: _images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/il_example_ads.jpg',
                              fit: BoxFit.cover,
                            ),
                          );
                          /*return Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          );*/
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      disableCenter: true,
                      aspectRatio: 10 / 5,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() => _currentIndex = entry.key),
                      child: Container(
                        width: 6.w,
                        height: 6.h,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Color(0x9f4376f8))
                                  .withOpacity(
                                      _currentIndex == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 80.h)
              ],
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
          SizedBox(height: 8.h),
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

  Widget _buildQuickActionButton(
      String image, String title, String subtitle, Function onTap) {
    return InkWell(
      onTap: (){
        onTap.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Image.asset(
                image,
                width: 30.w,
                height: 30.h,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (actionText != null)
            Text(
              actionText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      String title, String description, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 30.w,
            height: 30.h,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
