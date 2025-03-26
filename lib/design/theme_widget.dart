import 'package:flutter/material.dart';

enum ThemeWidget { blue, orange, red }

extension ThemeExt on ThemeWidget? {
  Color colorTheme() {
    switch (this) {
      case ThemeWidget.orange:
        return Colors.orange.shade700;
      case ThemeWidget.red:
        return Colors.red.shade700;
      default:
        return Colors.blue.shade700;
    }
  }
}

