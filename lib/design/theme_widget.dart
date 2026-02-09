import 'package:flutter/material.dart';

enum ThemeWidget { blue, orange, red, darkBlue, green, greyBackground }

extension ThemeExt on ThemeWidget? {
  Color colorTheme() {
    switch (this) {
      case ThemeWidget.green:
        return Colors.green.shade700;
      case ThemeWidget.darkBlue:
        return const Color(0XFF154B79);
      case ThemeWidget.orange:
        return Colors.orange.shade700;
      case ThemeWidget.red:
        return Colors.red.shade700;
      case ThemeWidget.greyBackground:
        return const Color(0xffF3F5F6);
      default:
        return Colors.blue.shade700;
    }
  }

  Color subColorTheme() {
    switch (this) {
      case ThemeWidget.green:
        return Colors.green.shade100;
      case ThemeWidget.darkBlue:
        return const Color(0XFF154B79);
      case ThemeWidget.orange:
        return Colors.orange.shade100;
      case ThemeWidget.red:
        return Colors.red.shade100;
      case ThemeWidget.greyBackground:
        return const Color(0xffF3F5F6);
      default:
        return Colors.blue.shade100;
    }
  }
}
