import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/theme_widget.dart';

class DoubleInfoWidget extends StatelessWidget {
  final String firstInfo;
  final String firstValue;
  final String? secondInfo;
  final String? secondValue;
  final ThemeWidget? theme;

  const DoubleInfoWidget({
    super.key,
    required this.firstInfo,
    required this.firstValue,
    this.secondInfo,
    this.secondValue,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              // Rounded corners
              border:
                  Border.all(color: Colors.grey.shade300), // Light grey border
            ),
            child: Column(
              children: [
                Text(firstInfo.toUpperCase()),
                Text(firstValue,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              // Rounded corners
              border: Border.all(
                  color: secondValue == null
                      ? theme.colorTheme()
                      : Colors.grey.shade300), // Light grey border
            ),
            child: Column(
              children: [
                Text(secondInfo?.toUpperCase() ?? ''),
                Text(
                  textAlign: TextAlign.center,
                  secondValue ?? '-',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: secondValue == null ? theme.colorTheme() : null),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
