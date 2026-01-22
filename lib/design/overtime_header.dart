import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/routing/core/bottom_sheet_page.dart';
import 'package:shelter_super_app/design/double_date_widget.dart';

class OverTimeHeader extends StatefulWidget {
  final String startDate;
  final String endDate;
  final Function(String) onChangeStartDate;
  final Function(String) onChangeEndDate;
  final Function(String) onChangeSearch;

  const OverTimeHeader({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onChangeStartDate,
    required this.onChangeEndDate,
    required this.onChangeSearch,
  });

  @override
  State<OverTimeHeader> createState() => _OverTimeHeaderState();
}

class _OverTimeHeaderState extends State<OverTimeHeader> {
  TextEditingController employeeController = TextEditingController();

  @override
  void dispose() {
    employeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Input Fields
          DoubleDateWidget(
            startDate: widget.startDate,
            endDate: widget.endDate,
            onChangeStartDate: (date) {},
            onChangeEndDate: (date) {},
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            child: TextField(
              cursorColor: Colors.blue[800],
              controller: employeeController,
              decoration: InputDecoration(
                labelText: 'Cari karyawan',
                contentPadding: EdgeInsets.zero,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (data) {
                widget.onChangeSearch.call(data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
