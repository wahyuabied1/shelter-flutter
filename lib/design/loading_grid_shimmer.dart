import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/shimmer.dart';

class LoadingGridShimmer extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double spacing;
  final double childAspectRatio;
  final Widget Function() itemBuilder;

  const LoadingGridShimmer({
    super.key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
    this.spacing = 16,
    this.childAspectRatio = 1.3,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (_, __) => itemBuilder(),
    );
  }
}

class SummaryShimmerCard extends StatelessWidget {
  const SummaryShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Spacer(),
            Container(
              width: 60,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
