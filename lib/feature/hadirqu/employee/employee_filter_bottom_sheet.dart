import 'package:flutter/material.dart';

class EmployeeFilterBottomSheet extends StatefulWidget {
  @override
  State<EmployeeFilterBottomSheet> createState() =>
      _EmployeeFilterBottomSheetState();
}

class _EmployeeFilterBottomSheetState extends State<EmployeeFilterBottomSheet> {
  final Map<String, bool> departments = {
    "Dept. Keamanan": false,
    "Dept. Kebersihan": false,
    "Dept. Quality Control": false,
    "Dept. Produksi": false,
    "Dept. Sales": false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Departemen",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: departments.keys.map((dept) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.white,
                  activeColor: Colors.blue.shade700,
                  title: Text(dept),
                  subtitle: Text(
                      "${(departments.keys.toList().indexOf(dept) + 1) * 3} Karyawan"),
                  value: departments[dept],
                  onChanged: (bool? value) {
                    setState(() {
                      departments[dept] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.blue.shade700),
                ),
                child: Text(
                  "Button text",
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
              const SizedBox(width: 12,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print(
                        "Selected departments: ${departments.entries.where((e) => e.value).map((e) => e.key).toList()}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                  ),
                  child: Text(
                    "Terapkan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
