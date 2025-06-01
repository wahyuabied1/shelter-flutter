import 'package:flutter/material.dart';

class ExportBottomSheet extends StatelessWidget {
  const ExportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Top indicator
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Export',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Export options
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildExportItem(
                      context,
                      icon: Icons.picture_as_pdf,
                      color: Colors.red,
                      title: 'Export PDF',
                      onTap: () {
                        // Your logic for PDF export
                        Navigator.of(context).pop();
                      },
                    ),
                    _buildExportItem(
                      context,
                      iconImage: 'assets/images/ic_excel.png',
                      color: Colors.green,
                      title: 'Export Laporan Kehadiran',
                      onTap: () {
                        // Your logic for XLS export
                        Navigator.of(context).pop();
                      },
                    ),
                    _buildExportItem(
                      context,
                      iconImage: 'assets/images/ic_excel.png',
                      color: Colors.green,
                      title: 'Export Rincian Scan Log',
                      onTap: () {
                        // Your logic for XLS export
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExportItem(
    BuildContext context, {
    String? iconImage,
    IconData? icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      child: ListTile(
        tileColor: Colors.white,
        leading: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(8),
          child: iconImage != null
              ? Image.asset(iconImage, width: 24, height: 24)
              : Icon(icon, color: color, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        onTap: onTap,
      ),
    );
  }
}
