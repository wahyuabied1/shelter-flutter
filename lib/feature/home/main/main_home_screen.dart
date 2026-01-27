import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/firebase_config/firebase_remote_config_service.dart';
import 'package:shelter_super_app/core/firebase_config/remote_config_key.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/enable_list_feature.dart';
import 'package:shelter_super_app/data/model/promotion_response.dart';
import 'package:shelter_super_app/design/shimmer.dart';
import 'package:shelter_super_app/feature/routes/cleaningqu_routes.dart';
import 'package:shelter_super_app/feature/routes/guard_routes.dart';
import 'package:shelter_super_app/feature/routes/hadirqu_routes.dart';
import 'package:shelter_super_app/feature/routes/issuequ_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_home_viewmodel.dart';

class MainHomeScreen extends StatelessWidget {
  final Function onNavigate;

  MainHomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainHomeViewmodel>(
      create: (context) => MainHomeViewmodel()..init(),
      child: _MainHomeView(
        onNavigate: onNavigate,
      ),
    );
  }
}

class _MainHomeView extends StatefulWidget {
  final Function onNavigate;

  const _MainHomeView({required this.onNavigate});

  @override
  State<_MainHomeView> createState() => _MainHomeState();
}

class _MainHomeState extends State<_MainHomeView> {
  int _currentIndex = 0;
  final _remoteConfig = serviceLocator.get<FirebaseRemoteConfigService>();
  List<PromotionResponse> listData = [];
  EnableListFeature? enableFeature;

  @override
  initState(){
    super.initState();
    _remoteConfig.streamString(promotion).listen((value) {
      setState(() {
        List<dynamic> jsonList = jsonDecode(value);
        listData = jsonList.map((json) => PromotionResponse.fromJson(json)).toList();  // your variable
      });
    });

    _remoteConfig.streamString(enableListFeature).listen((value) {
      setState(() {
        enableFeature = EnableListFeature.fromJson(jsonDecode(value));
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<MainHomeViewmodel>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vm.greeting ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vm.userResult.dataOrNull?.user?.nama ?? '-',
                  style: const TextStyle(
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickActionButton(
                      vm.userResult.isLoading,
                      (vm.userResult.dataOrNull?.menus?.hadirKu ?? false) && (enableFeature?.hadirqu ?? false),
                      AppAssets.icIconHadirqu,
                      'HadirQu',
                      '(Kehadiran)', () {
                    context.pushNamed(HadirQuRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      vm.userResult.isLoading,
                      (vm.userResult.dataOrNull?.menus?.cleaningQu ?? false)  && (enableFeature?.cleaningqu ?? false),
                      AppAssets.icIconCleaningqu,
                      'CleaningQu',
                      '(Kebersihan)', () {
                    context.pushNamed(CleaningquRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      vm.userResult.isLoading,
                      (vm.userResult.dataOrNull?.menus?.issueQu ?? false) && (enableFeature?.issuequ ?? false),
                      AppAssets.icIconIssuequ,
                      'IssueQu',
                      '(Keluhan)', () {
                    context.pushNamed(IssueQuRoutes.home.name!);
                  }),
                  _buildQuickActionButton(
                      vm.userResult.isLoading,
                      (vm.userResult.dataOrNull?.menus?.poskoPatrol ?? false) && (enableFeature?.guard ?? false),
                      AppAssets.icIconGuard,
                      'Guard',
                      '(Keamanan)', () {
                    context.pushNamed(GuardRoutes.home.name!);
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
                // _buildSectionHeader('Notifikasi', 'Lihat Semua', () {
                //   widget.onNavigate(1);
                // }),
                // _buildNotificationItem(
                //     'HadirQu',
                //     'Pengajuan Cuti dari Agus Hariyono',
                //     AppAssets.ilIconHadirqu),
                // _buildNotificationItem(
                //     'IssueQu',
                //     'Keluhan dijawab oleh tim ops Shelter',
                //     AppAssets.ilIconIssuequ),

                // Promotions Section
                _buildSectionHeader('Promosi', null, null),
                SizedBox(height: 8),
                CarouselSlider(
                  items: listData.map((data) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            launchBrowser(data.url);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              data.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listData.asMap().entries.map((entry) {
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
                                      : Colors.blue.shade700)
                                  .withOpacity(
                                      _currentIndex == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 40.h)
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
    bool isLoading,
    bool isVisible,
    String image,
    String title,
    String subtitle,
    Function onTap,
  ) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            onTap.call();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            children: [
              Shimmer(
                isLoading: isLoading,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    image,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Shimmer(
                isLoading: isLoading,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Shimmer(
                isLoading: isLoading,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String? actionText, Function? onClickActionText) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8),
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
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                onClickActionText?.call();
              },
              child: Text(
                actionText,
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
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

  void launchBrowser(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // can't launch url
    }
  }
}
