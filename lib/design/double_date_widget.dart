import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class DoubleDateWidget extends StatefulWidget {
  String startDate;
  String endDate;

  final Function(String) onChangeStartDate;
  final Function(String) onChangeEndDate;

  ThemeWidget? theme;

  DoubleDateWidget({
    super.key,
    required this.endDate,
    required this.startDate,
    required this.onChangeStartDate,
    required this.onChangeEndDate,
    this.theme = ThemeWidget.blue,
  });

  @override
  State<DoubleDateWidget> createState() => _DoubleDateWidgetState();
}

class _DoubleDateWidgetState extends State<DoubleDateWidget> {
  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
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
                onTap: () => _selectDate(context, true),
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
                      Flexible(child: Text(widget.startDate)),
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
                onTap: () => _selectDate(context, false),
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
                      Flexible(child: Text(widget.endDate)),
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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.theme?.colorTheme() ?? Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = _formatDate(pickedDate);

      setState(() {
        if (isStartDate) {
          widget.startDate = formatted;

          widget.onChangeStartDate.call(formatted);
        } else {
          widget.endDate = formatted;

          widget.onChangeEndDate.call(formatted);
        }
      });
    }
  }
}
