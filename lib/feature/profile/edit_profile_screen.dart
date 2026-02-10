import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/core/utils/image_picker.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/design/common_loading_dialog.dart';
import 'package:shelter_super_app/design/default_snackbar.dart';
import 'package:shelter_super_app/design/shimmer.dart';
import 'package:shelter_super_app/design/success_bottom_sheet.dart';
import 'package:shelter_super_app/feature/profile/view_model/edit_profile_viewmodel.dart';
import 'package:shelter_super_app/feature/routes/homepage_routes.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileViewmodel>(
      create: (context) => EditProfileViewmodel()..init(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<_EditProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailNameController;
  late TextEditingController _addressNameController;
  File? _imageFile;

  Future<void> _updatePhoto() async {
    final File? image = await showPickerOptions(context);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var vm = context.read<EditProfileViewmodel>();
    _nameController = TextEditingController(
      text: vm.userResult.dataOrNull?.user?.nama ?? "",
    );
    _userNameController = TextEditingController(
      text: vm.userResult.dataOrNull?.user?.username ?? "",
    );
    _emailNameController = TextEditingController(
      text: vm.userResult.dataOrNull?.user?.email ?? "",
    );
    _addressNameController = TextEditingController(
      text: vm.userResult.dataOrNull?.user?.alamat ?? "",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailNameController.dispose();
    _addressNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<EditProfileViewmodel>();
    final user = vm.userResult.dataOrNull?.user;
    if (user != null) {
      if (_nameController.text != (user.nama ?? "")) {
        _nameController.text = user.nama ?? "";
      }
      if (_userNameController.text != (user.username ?? "")) {
        _userNameController.text = user.username ?? "";
      }
      if (_emailNameController.text != (user.email ?? "")) {
        _emailNameController.text = user.email ?? "";
      }
      if (_addressNameController.text != (user.alamat ?? "")) {
        _addressNameController.text = user.alamat ?? "";
      }
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: false,
        backgroundColor: const Color(0xFF205B9A),
        elevation: 0,
        title: const Text('Edit Profile',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(
                    top: 80, left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Informasi Data Diri',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Nama Lengkap',
                      controller: _nameController,
                      onValueChanged: (val) =>
                          {vm.onChangeName(_nameController.text)},
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      label: 'NIK/Username',
                      controller: _userNameController,
                      onValueChanged: (val) =>
                          {vm.onChangeUsername(_userNameController.text)},
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      label: 'Email',
                      controller: _emailNameController,
                      keyboardType: TextInputType.emailAddress,
                      onValueChanged: (val) =>
                          {vm.onChangeEmail(_emailNameController.text)},
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      label: 'Alamat',
                      controller: _addressNameController,
                      maxLines: 3,
                      onValueChanged: (val) =>
                          {vm.onChangeAddress(_addressNameController.text)},
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              child: Text(
                                "Kembali",
                                style: TextStyle(color: Colors.blue.shade700),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (context) {
                                    return SuccessBottomSheet(
                                      title: "Konfirmasi Simpan",
                                      image: AppAssets.ilEmail,
                                      desc:
                                          'Apakah anda yakin untuk menyimpan perubahan ?',
                                      buttonText: 'Kembali',
                                      actionTextPrimary: () {
                                        _saveProfile(vm);
                                      },
                                      buttonTextPrimary: "Simpan",
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                              ),
                              child: const Text(
                                "Simpan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Shimmer(
                        isLoading: vm.userResult.isLoading,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue.shade700,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) as ImageProvider
                              : (vm.userResult.dataOrNull?.user?.foto != null &&
                                      vm.userResult.dataOrNull!.user!.foto!
                                          .isNotEmpty
                                  ? NetworkImage(
                                      vm.userResult.dataOrNull!.user!.foto!,
                                    ) as ImageProvider
                                  : null),
                          child: (_imageFile == null &&
                                  (vm.userResult.dataOrNull?.user?.foto ==
                                          null ||
                                      vm.userResult.dataOrNull!.user!.foto!
                                          .isEmpty))
                              ? Text(
                                  (vm.userResult.dataOrNull?.user?.nama ?? "-")
                                      .initialName(),
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.edit,
                              size: 16, color: Colors.white),
                          onPressed: () {
                            _updatePhoto();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required Function(String) onValueChanged,
  }) {
    var vm = context.watch<EditProfileViewmodel>();

    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        cursorColor: Colors.blue[800],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: Colors.blue.shade700),
          ),
          labelStyle: const TextStyle(color: Colors.black54),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          onValueChanged.call(value);
        });
  }

  Future<void> _saveProfile(EditProfileViewmodel vm) async {
    await LoadingDialog.runWithLoading(
      context,
      () async {
        // Upload foto dulu jika ada foto baru yang dipilih
        if (_imageFile != null) {
          await vm.updatePhoto(_imageFile);
          if (mounted) {
            setState(() {
              _imageFile = null;
            });
          }
        }

        // Kemudian update profile data lainnya
        await vm.changeProfile();

        // Refresh session dari server untuk mendapatkan data terbaru
        // (termasuk foto URL baru, seperti efek login ulang)
        await vm.refreshSession();
      },
      width: 250,
      message: "Memproses",
    ).then((value) {
      if (!mounted) return;
      if (vm.updateResult.isSuccess) {
        showDefaultSuccess(context, "Berhasil mengubah profile!");
        context
            .goNamed(HomepageRoutes.main.name!, queryParameters: {'page': '2'});
      } else if (vm.updateResult.isError) {
        showDefaultError(context, vm.updateResult.error);
      }
    });
  }
}
