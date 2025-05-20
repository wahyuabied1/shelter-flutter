import 'package:flutter/material.dart';

enum ThemeWidget { blue, orange, red, darkBlue }

extension ThemeExt on ThemeWidget? {
  Color colorTheme() {
    switch (this) {
      case ThemeWidget.darkBlue:
        return Color(0XFF154B79);
      case ThemeWidget.orange:
        return Colors.orange.shade700;
      case ThemeWidget.red:
        return Colors.red.shade700;
      default:
        return Colors.blue.shade700;
    }
  }
}

