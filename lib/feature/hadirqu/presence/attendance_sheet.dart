import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceSheet extends StatelessWidget {
  final String name;
  final String role;
  final String id;
  final String imageUrl;
  final List<Map<String, dynamic>> attendanceData; // Only actual data

  const AttendanceSheet({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.imageUrl,
    required this.attendanceData,
  });

  @override
  Widget build(BuildContext context) {
    // Generate full list of dates for November 2024
    final List<DateTime> monthDates = List.generate(30, (index) {
      return DateTime(2024, 11, index + 1);
    });

    // Convert attendanceData to a map for faster lookup
    final Map<int, Map<String, dynamic>> dataMap = {
      for (var entry in attendanceData) entry['day']: entry,
    };

    final fullAttendanceList = monthDates.map((date) {
      final day = date.day;
      final weekdayName = DateFormat('EEEE', 'id_ID').format(date);
      final shortWeekday = DateFormat('EEE', 'id_ID').format(date);
      final data = dataMap[day];
      return {
        'date': '$shortWeekday\n${day.toString().padLeft(2, '0')}',
        'statuses': data?['statuses'] ?? [],
        'desc': data?['desc'] ?? '-',
      };
    }).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(role,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(id,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('November 2024',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Divider(height: 1),
              // Table
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: fullAttendanceList.length,
                  itemBuilder: (context, index) {
                    final item = fullAttendanceList[index];
                    final isEven = index % 2 == 0;
                    return Container(
                      color: isEven ? Colors.white : Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              item['date'],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                ...?item['statuses']?.map<Widget>((status) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(status['type']),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      status['type'],
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(item['desc'] ?? '-',
                                      style:
                                      const TextStyle(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String statusType) {
    switch (statusType) {
      case 'H':
        return Colors.green;
      case 'T':
        return Colors.orange;
      case '?':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }
}