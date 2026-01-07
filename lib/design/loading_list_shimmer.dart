import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter_super_app/design/shimmer.dart';

class LoadingListShimmer extends StatefulWidget {
  final int count;
  final bool isContainsLeading;

  const LoadingListShimmer(
      {super.key, required this.count, this.isContainsLeading = true});

  @override
  State<LoadingListShimmer> createState() => _LoadingListShimmerState();
}

Widget getContentShimmer(bool isContainsLeading) {
  return ListTile(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: SizedBox(
          height: 10.h,
        ),
      ),
      subtitle: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: SizedBox(
          height: 10.h,
        ),
      ),
      leading: isContainsLeading
          ? CircleAvatar(
        radius: 20.h,
        child: null,
      )
          : null);
}

class _LoadingListShimmerState extends State<LoadingListShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: true,
      child: SizedBox(
        height: (68.h * widget.count).toDouble(),
        width: double.infinity,
        child: ListView.builder(
          itemCount: widget.count,
          itemBuilder: (context, i) {
            return getContentShimmer(widget.isContainsLeading);
          },
        ),
      ),
    );
  }
}
