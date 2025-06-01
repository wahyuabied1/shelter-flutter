import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String id;
  final String time;
  final String site;
  final String? statusIcon; // 'H', 'P', 'T' etc.
  final String? statusColor;
  final String imageUrl;

  const EmployeeCard({
    super.key,
    required this.name,
    required this.id,
    required this.time,
    required this.site,
    this.statusIcon,
    this.statusColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 12),
                // Main Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and ID
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              id,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Email & Location
                      Text(
                        '${name.toLowerCase().replaceAll(" ", "")} • SG',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Clocked Time & Site Kerja
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 90,
                    ),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  size: 20,
                                ),
                                SizedBox(width: 12),
                                Text("Clocked Time",
                                    style: TextStyle(color: Colors.black54)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(time,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black87))
                          ],
                        ),
                        statusIcon != null
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(statusColor),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      statusIcon!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 90,
                    ),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey.shade300), // Light grey border
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.navigation_outlined,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text("Site Kerja",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          textAlign: TextAlign.center,
                          site,
                          style: TextStyle(color: Colors.black87),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? statusColor) {
    switch (statusColor) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow.shade700;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
