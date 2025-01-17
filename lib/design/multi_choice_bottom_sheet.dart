import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiChoiceBottomSheet extends StatefulWidget {
  final String title;
  final Map<String, bool> choice;

  const MultiChoiceBottomSheet({
    super.key,
    required this.title,
    required this.choice,
  });

  @override
  State<MultiChoiceBottomSheet> createState() => _MultiChoiceBottomSheetState();
}

class _MultiChoiceBottomSheetState extends State<MultiChoiceBottomSheet> {
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
                      Text(dept),
                      Text(
                        "${(widget.choice.keys.toList().indexOf(dept) + 1) * 3} Karyawan",
                        style: TextStyle(fontSize: 12.sp,color: Colors.grey.shade600),
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
                  side: BorderSide(width: 1.0, color: Colors.blue.shade700),
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.blue.shade700),
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
