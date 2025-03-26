import 'package:flutter/material.dart';

class DoubleListTile extends StatelessWidget {
  final IconData firstIcon;
  final String firstTitle;
  final String firstSubtitle;
  final IconData? secondIcon;
  final String? secondTitle;
  final String? secondSubtitle;

  const DoubleListTile(
      {super.key,
      required this.firstIcon,
      required this.firstTitle,
      required this.firstSubtitle,
      this.secondIcon,
      this.secondTitle,
      this.secondSubtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            leading: Icon(
              firstIcon,
            ),
            title: Text(
              firstTitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            subtitle: Text(
              firstSubtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: secondIcon != null ? Icon(secondIcon) : null,
            dense: true,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              secondTitle ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            subtitle: Text(
              secondSubtitle??'',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        )
      ],
    );
  }
}
