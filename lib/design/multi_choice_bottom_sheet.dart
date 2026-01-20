import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class MultiChoiceBottomSheet extends StatefulWidget {
  final String title;
  final Map<String, bool> choice;
  final ThemeWidget? theme;
  final Function(Map<String, bool>)?
      onApply; // Callback untuk mengembalikan hasil

  MultiChoiceBottomSheet({
    super.key,
    required this.title,
    required this.choice,
    this.theme = ThemeWidget.blue,
    this.onApply,
  });

  @override
  State<MultiChoiceBottomSheet> createState() => _MultiChoiceBottomSheetState();
}

class _MultiChoiceBottomSheetState extends State<MultiChoiceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.grey.shade300),
            ),
            width: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
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
              children: widget.choice.keys.map((dept) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.white,
                  activeColor: widget.theme?.colorTheme(),
                  title: SizedBox(
                    width: 150,
                    child: Text(dept),
                  ),
                  value: widget.choice[dept],
                  onChanged: (bool? value) {
                    setState(() {
                      widget.choice[dept] = value!;
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
                onPressed: () {
                  setState(() {
                    widget.choice.forEach((key, value) {
                      widget.choice[key] = false;
                    });
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1.0,
                    color: widget.theme!.colorTheme(),
                  ),
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(color: widget.theme!.colorTheme()),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 220.w,
                child: ElevatedButton(
                  onPressed: () {
                    // Return hasil selection
                    Navigator.pop(context, widget.choice);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.theme!.colorTheme(),
                  ),
                  child: const Text(
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
