import 'package:flutter/material.dart';

class StatusFilterChips extends StatefulWidget {
  const StatusFilterChips({super.key});

  @override
  State<StatusFilterChips> createState() => _StatusFilterChipsState();
}

class _StatusFilterChipsState extends State<StatusFilterChips> {
  final List<String> statuses = [
    "Menunggu",
    "Sedang dikerjakan",
    "Menunggu Approval",
    "Selesai",
    "Ditolak"
  ];

  final List<String> selectedStatuses = [];

  void toggleSelection(String status) {
    setState(() {
      if (selectedStatuses.contains(status)) {
        selectedStatuses.remove(status);
      } else {
        selectedStatuses.add(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statuses.map((status) {
          final isSelected = selectedStatuses.contains(status);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => toggleSelection(status),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1D4ED8) : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF1D4ED8) : Colors.black26,
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
