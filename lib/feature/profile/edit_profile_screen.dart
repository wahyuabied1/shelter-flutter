import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';
import 'package:shelter_super_app/design/success_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = 'Dwisandi Arifin';
  String username = '3515143289070001';
  String email = 'email@example.com';
  String address =
      'PT. SHELTER NUSANTARA\nJL. Semampir Selatan V A NO.18\nSurabaya 60119';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: false,
        backgroundColor: Color(0xFF205B9A),
        elevation: 0,
        title: Text('Edit Profile',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top:50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(
                    top: 80, left: 16, right: 16, bottom: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Informasi Data Diri',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      _buildTextField(
                        label: 'Nama Lengkap',
                        initialValue: fullName,
                        onSaved: (val) => fullName = val!,
                      ),
                      SizedBox(height: 12),
                      _buildTextField(
                        label: 'NIK/Username',
                        initialValue: username,
                        onSaved: (val) => username = val!,
                      ),
                      SizedBox(height: 12),
                      _buildTextField(
                        label: 'Email',
                        initialValue: email,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (val) => email = val!,
                      ),
                      SizedBox(height: 12),
                      _buildTextField(
                        label: 'Alamat',
                        initialValue: address,
                        maxLines: 3,
                        onSaved: (val) => address = val!,
                      ),
                      SizedBox(height: 24),
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
                          SizedBox(width: 12),
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
                                          _saveProfile();
                                          context.pop();
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
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue.shade700,
                        child: Text(
                          fullName.initialName(),
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.edit, size: 16, color: Colors.white),
                          onPressed: () {},
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
    required String initialValue,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.black26),
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
      onSaved: onSaved,
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil disimpan')),
      );
    }
  }
}
