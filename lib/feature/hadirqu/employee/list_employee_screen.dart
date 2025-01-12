import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/feature/hadirqu/employee/employee_filter_bottom_sheet.dart';
import 'package:shelter_super_app/feature/hadirqu/employee/profile_card.dart';

class ListEmployeeScreen extends StatefulWidget {
  @override
  _ListEmployeeScreenState createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  final List<Map<String, dynamic>> employees = [
    {
      "name": "Justinus William",
      "id": "KRY-001",
      "department": "Keamanan",
      "position": "Staff",
      "group": "Tim Keamanan",
      "site": "AMERTA INDAH OTSUKA KEJAYAN",
      "schedule": [
        {"days": "Senin, Rabu, Jumat", "time": "08.00 - 16.00"},
        {"days": "Selasa, Kamis, Rabu", "time": "19.00 - 23.00"}
      ]
    },
    {
      "name": "Justinus William",
      "id": "KRY-001",
      "department": "Keamanan",
      "position": "Staff",
      "group": "Tim Keamanan",
      "site": "AMERTA INDAH OTSUKA KEJAYAN",
      "schedule": [
        {"days": "Senin, Rabu, Jumat", "time": "08.00 - 16.00"},
        {"days": "Selasa, Kamis, Rabu", "time": "19.00 - 23.00"}
      ]
    },
    {
      "name": "Justinus William",
      "id": "KRY-001",
      "department": "Keamanan",
      "position": "Staff",
      "group": "Tim Keamanan",
      "site": "AMERTA INDAH OTSUKA KEJAYAN",
      "schedule": [
        {"days": "Senin, Rabu, Jumat", "time": "08.00 - 16.00"},
        {"days": "Selasa, Kamis, Rabu", "time": "19.00 - 23.00"}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF3F5F6),
      appBar: AppBar(
        titleSpacing: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "List Karyawan",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari karyawan',
                hintStyle: TextStyle(color: Colors.black12),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 1,color: Colors.black12),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1,color: Colors.black12)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1,color: Colors.blue.shade700)
                )
              ),
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return EmployeeFilterBottomSheet();
                        },
                      );
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                        border: Border.all(color: Colors.grey.shade300), // Light grey border
                      ),
                      child: const Row(children: [
                        Text('Departemen'),
                        SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                      ],)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return EmployeeFilterBottomSheet();
                          },
                        );
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                            border: Border.all(color: Colors.grey.shade300), // Light grey border
                          ),
                          child: const Row(children: [
                            Text('Jabatan'),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                          ],)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return EmployeeFilterBottomSheet();
                        },
                      );
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20), // Rounded corners
                          border: Border.all(color: Colors.grey.shade300), // Light grey border
                        ),
                        child: Row(children: [
                          Text('Group/Template'),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
                        ],)
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return ProfileCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
