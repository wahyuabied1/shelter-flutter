import 'package:alice/utils/alice_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class PresensiFilterBottomSheet extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? initialFilter;
  final ThemeWidget theme;

  const PresensiFilterBottomSheet({
    super.key,
    required this.title,
    this.initialFilter,
    this.theme = ThemeWidget.blue,
  });

  @override
  State<PresensiFilterBottomSheet> createState() =>
      _PresensiFilterBottomSheetState();
}

class _PresensiFilterBottomSheetState extends State<PresensiFilterBottomSheet> {
  // Data status absensi
  final List<Map<String, dynamic>> statusAbsensi = [
    {"status": -1, "text": "Presensi Ditolak"},
    {"status": 0, "text": "Absen"},
    {"status": 1, "text": "Hadir"},
    {"status": 2, "text": "Izin"},
    {"status": 3, "text": "Sakit"},
    {"status": 4, "text": "Terlambat"},
    {"status": 5, "text": "Lembur"},
    {"status": 6, "text": "Diluar lokasi"},
    {"status": 7, "text": "Diluar lokasi & Terlambat"},
    {"status": 8, "text": "Cuti"},
    {"status": 9, "text": "Pulang Cepat"},
    {"status": 10, "text": "Tidak Clock out"},
  ];

  // Operator options
  final List<Map<String, String>> operators = [
    {"value": ">", "label": "Lebih dari"},
    {"value": "<", "label": "Kurang dari"},
    {"value": "=", "label": "Sama dengan"},
  ];

  String? selectedOperator;
  int? selectedStatusCode;
  String? selectedStatusText;
  final TextEditingController _jumlahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialFilter != null) {
      selectedOperator = widget.initialFilter!['operator'];
      selectedStatusCode = widget.initialFilter!['statusCode'];
      selectedStatusText = widget.initialFilter!['statusText'];
      _jumlahController.text =
          widget.initialFilter!['jumlah']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AliceConstants.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Dropdown Sections
          Row(
            children: [
              // Status Dropdown
              Expanded(
                child: _buildDropdown(
                  label: selectedStatusText ?? 'Hadir',
                  items: statusAbsensi
                      .map((s) => DropdownMenuItem<int>(
                            value: s['status'],
                            child: Text(
                              s['text'],
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ))
                      .toList(),
                  value: selectedStatusCode ?? 1,
                  onChanged: (value) {
                    setState(() {
                      selectedStatusCode = value;
                      selectedStatusText = statusAbsensi
                          .firstWhere((s) => s['status'] == value)['text'];
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              // Operator Dropdown
              Expanded(
                child: _buildDropdown(
                  label: selectedOperator != null
                      ? operators.firstWhere(
                          (op) => op['value'] == selectedOperator)['label']!
                      : 'Lebih dari',
                  items: operators
                      .map((op) => DropdownMenuItem<String>(
                            value: op['value'],
                            child: Text(
                              op['label']!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ))
                      .toList(),
                  value: selectedOperator ?? '>',
                  onChanged: (value) {
                    setState(() {
                      selectedOperator = value;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Input Jumlah Field
          TextFormField(
            controller: _jumlahController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah ${selectedStatusText ?? "Hadir"}',
              hintText: 'Masukkan jumlah',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: widget.theme.colorTheme()),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),

          SizedBox(height: 64.h),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RESET
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedOperator = null;
                    selectedStatusCode = null;
                    selectedStatusText = null;
                    _jumlahController.clear();
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1.0,
                    color: widget.theme.colorTheme(),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(color: widget.theme.colorTheme()),
                ),
              ),

              const SizedBox(width: 12),

              SizedBox(
                width: 220.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'operator': selectedOperator ?? '>',
                      'statusCode': selectedStatusCode ?? 1,
                      'statusText': selectedStatusText ?? 'Hadir',
                      'jumlah': int.tryParse(_jumlahController.text) ?? 0,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme.colorTheme(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: const Text(
                    "Terapkan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required List<DropdownMenuItem<T>> items,
    required T value,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          dropdownColor: AliceConstants.white,
          items: items,
          onChanged: onChanged,
          icon: Icon(Icons.arrow_drop_down, color: widget.theme.colorTheme()),
        ),
      ),
    );
  }
}
