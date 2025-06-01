import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';
import 'package:shelter_super_app/design/success_bottom_sheet.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: false,
        title: Text(
          "Ubah Password",
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Buat Password Baru',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D1C3D),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Masukkan password sekarang.'),
                      const SizedBox(height: 12),
                      _buildPasswordField(
                        label: 'Password Sekarang',
                        controller: _currentPasswordController,
                        visible: _currentPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _currentPasswordVisible = !_currentPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text.rich(
                        TextSpan(
                          text:
                              'Buat password baru, pastikan password memiliki kombinasi huruf besar ',
                          children: [
                            TextSpan(
                              text: 'huruf kecil',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' dan '),
                            TextSpan(
                              text: 'angka',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPasswordField(
                        label: 'Password Baru',
                        controller: _newPasswordController,
                        visible: _newPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _newPasswordVisible = !_newPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildPasswordField(
                        label: 'Ulangi Password Baru',
                        controller: _confirmPasswordController,
                        visible: _confirmPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: !visible,
          decoration: InputDecoration(
            hintText: '*********',
            hintStyle: TextStyle(color: Colors.black12),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: Colors.black26),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: Colors.blue.shade700),
            ),
            labelStyle: const TextStyle(color: Colors.black54),
            suffixIcon: IconButton(
              icon: Icon(
                visible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                onToggle.call();
              },
            ),
          ),
        ),
      ],
    );
  }
}
