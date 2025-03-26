import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiChoiceBottomSheet extends StatefulWidget {
  final String title;
  final Map<String, bool> choice;
  MultiChoiceBottomSheetTheme? theme;

  MultiChoiceBottomSheet({
    super.key,
    required this.title,
    required this.choice,
    this.theme,
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
        // Rounded corners
        border: Border.all(color: Colors.grey.shade300), // Light grey border
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300 ,
              borderRadius: BorderRadius.circular(2),
              // Rounded corners
              border: Border.all(color: Colors.grey.shade300), // Light grey border
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
                  activeColor: Colors.blue.shade700,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(dept),
                      ),
                      Spacer(),
                      Text(
                        "${(widget.choice.keys.toList().indexOf(dept) + 1) * 3} Karyawan",
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey.shade600),
                      )
                    ],
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
                  side: BorderSide(width: 1.0, color: _colorTheme()),
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(color: _colorTheme()),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 220.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _colorTheme(),
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

  Color _colorTheme() {
    switch (widget.theme) {
      case MultiChoiceBottomSheetTheme.orange:
        return Colors.orange.shade700;
      default:
        return Colors.blue.shade700;
    }
  }
}

enum MultiChoiceBottomSheetTheme { blue, orange, red }
