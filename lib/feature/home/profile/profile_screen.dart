import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/core/basic_extensions/string_extension.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "Dwisandi Arifin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20.sp,
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
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade700,
                      child: Text(
                        name.initialName(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(
                              Icons.person,
                              size: 20,
                            ),
                            title: Text(
                              'Dwi Shelter Indonesia',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(
                              Icons.email,
                              size: 20,
                            ),
                            title: Text(
                              'email@example.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            contentPadding: EdgeInsets.all(0),
                            leading: Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                            title: Text(
                              'PT. SHELTER NUSANTARA\nJL. Semampir Selatan V A NO.18\nSurabaya 60119',
                              style: TextStyle(
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
                        onTap:(){},
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
                        leading: Icon(Icons.lock, color: Colors.blue.shade700),
                        title: Text(
                          'Ubah Password',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Perbarui Sekuritas Akun'),
                        onTap: () {},
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
                onTap: () {},
              ),
            ),
          ),

          const Padding(
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
                        Text(
                          'User Sejak: 21-May-2021',
                          style: TextStyle(color: Colors.black87, fontSize: 12),
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
                      'Update Terakhir: 07-Jun-2023',
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
