import 'dart:ui';

class Task {
  final String status;
  final String priority;
  final Color priorityColor;
  final String title;
  final String date;
  final String deadline;
  final String by;

  Task({
    required this.status,
    required this.priority,
    required this.priorityColor,
    required this.title,
    required this.date,
    required this.deadline,
    required this.by,
  });
}
