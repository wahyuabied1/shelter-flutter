import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/utils/page_resume.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';
import 'package:shelter_super_app/design/common_loading_dialog.dart';
import 'package:shelter_super_app/design/shimmer.dart';
import 'package:shelter_super_app/feature/home/profile/profile_viewmodel.dart';
import 'package:shelter_super_app/feature/routes/homepage_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewmodel>(
      create: (context) => ProfileViewmodel()..init(),
      child: _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileView> {
  final authRepository = serviceLocator.get<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<ProfileViewmodel>();

    return PageResume(
      onResume: () => vm.getUser(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(
                        isLoading: vm.userResult.isLoading,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade700,
                          backgroundImage:
                              (vm.userResult.dataOrNull?.user?.foto != null &&
                                      vm.userResult.dataOrNull!.user!.foto!
                                          .isNotEmpty)
                                  ? NetworkImage(
                                      '${vm.userResult.dataOrNull!.user!.foto!.split('?').first}?v=${vm.fotoVersion}')
                                  : null,
                          child: (vm.userResult.dataOrNull?.user?.foto ==
                                      null ||
                                  vm.userResult.dataOrNull!.user!.foto!.isEmpty)
                              ? Text(
                                  vm.userResult.dataOrNull?.user?.nama
                                          ?.initialName() ??
                                      '-',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vm.userResult.dataOrNull?.user?.nama ?? '-',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              minVerticalPadding: 0,
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              contentPadding: EdgeInsets.all(0),
                              leading: const Icon(
                                Icons.person,
                                size: 20,
                              ),
                              title: Text(
                                vm.userResult.dataOrNull?.user?.username ?? '-',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            ListTile(
                              minVerticalPadding: 0,
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              contentPadding: EdgeInsets.all(0),
                              leading: const Icon(
                                Icons.email,
                                size: 20,
                              ),
                              title: Text(
                                vm.userResult.dataOrNull?.user?.email ?? '-',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            ListTile(
                              minVerticalPadding: 0,
                              dense: true,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              contentPadding: EdgeInsets.all(0),
                              leading: const Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              title: Text(
                                vm.userResult.dataOrNull?.user?.alamat ?? '-',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Preferences Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            context.pushNamed(HomepageRoutes.editProfile.name!);
                          },
                          leading:
                              Icon(Icons.person, color: Colors.blue.shade700),
                          title: Text(
                            'Ubah Profile',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Perbarui Informasi Profile'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.lock, color: Colors.blue.shade700),
                          title: Text(
                            'Ubah Password',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Perbarui Sekuritas Akun'),
                          onTap: () {
                            context.pushNamed(HomepageRoutes.changePass.name!);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Card(
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Securely logout your Account'),
                  onTap: () async {
                    await LoadingDialog.runWithLoading(
                      context,
                      () => vm.logout(),
                      width: 250,
                      message: "Memproses Logout",
                    ).then((value) {
                      if (!context.mounted) return;
                      if (vm.logoutResult.isSuccess) {
                        showDefaultSnackbar(
                            "Berhasil Logout", vm.logoutResult.isSuccess);
                        context.pushNamed(HomepageRoutes.login.name!);
                      } else if (vm.logoutResult.isError) {
                        showDefaultSnackbar(
                            vm.logoutResult.error, vm.logoutResult.isSuccess);
                      }
                    });
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 8),
                          Shimmer(
                            isLoading: vm.userResult.isLoading,
                            child: Text(
                              'User Sejak: ${vm.getUserCreatedDate()}',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Icon(Icons.update, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Update Terakhir: ${vm.getUserUpdatedDate()}',
                        style: TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDefaultSnackbar(String errorMessage, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(errorMessage),
      ),
    );
  }
}
