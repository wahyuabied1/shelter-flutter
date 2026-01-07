import 'package:flutter/material.dart';
import 'package:shelter_super_app/app/assets/app_assets.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const EmptyListWidget({super.key,required this.title, required this.subtitle,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              AppAssets.icEmptyList,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
