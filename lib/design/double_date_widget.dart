import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/date_time_formatter_extension.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class DoubleDateWidget extends StatefulWidget {

  DateTime startDate;
  DateTime endDate;
  final Function(DateTimeRange) onChangeDate;
  ThemeWidget theme;

  DoubleDateWidget({
    super.key,
    required this.endDate,
    required this.startDate,
    required this.onChangeDate,
    required this.theme,
  });

  @override
  State<DoubleDateWidget> createState() => _DoubleDateWidgetState();
}

class _DoubleDateWidgetState extends State<DoubleDateWidget> {
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedRange = DateTimeRange(start: widget.startDate, end: widget.endDate);
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tanggal Mulai'),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: (){
                  _pickDateRange();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      const SizedBox(width: 8.0),
                      Flexible(child: Text(_selectedRange!.start.ddMMyyyy('/'))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tanggal Berakhir'),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: (){
                  _pickDateRange();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      const SizedBox(width: 8.0),
                      Flexible(child: Text(_selectedRange!.end.ddMMyyyy('/'))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final fallbackRange = DateTimeRange(
      start: today,
      end: today,
    );

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: today, // disable tomorrow & future
      initialDateRange: _selectedRange ?? fallbackRange,
      initialEntryMode: DatePickerEntryMode.calendar, // ✅ can switch to input
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.theme.colorTheme(),
              secondary: widget.theme.subColorTheme(),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedRange = picked);
      widget.onChangeDate(picked);
    }
  }
}
