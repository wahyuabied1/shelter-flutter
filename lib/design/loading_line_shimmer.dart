import 'package:flutter/material.dart';
import 'package:shelter_super_app/design/shimmer.dart';

class LoadingLineShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final bool marginHorizontal;
  final bool marginVertikal;

  const LoadingLineShimmer(
      {super.key,
      this.width = double.infinity,
      this.height = 16,
      this.radius = 4,
      this.marginHorizontal = false,
      this.marginVertikal = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: true,
      child: Container(
        margin: EdgeInsets.only(
          top: marginVertikal ? 16 : 0,
          bottom: marginVertikal ? 16 : 0,
          left: marginHorizontal ? 16 : 0,
          right: marginHorizontal ? 16 : 0,
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
