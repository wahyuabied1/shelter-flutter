import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessBottomSheet extends StatefulWidget {
  final String? image;
  final String? title;
  final String? desc;
  final String? buttonText;

  const SuccessBottomSheet({
    super.key,
    this.image,
    this.title,
    this.desc,
    this.buttonText,
  });

  @override
  State<SuccessBottomSheet> createState() => _MultiChoiceBottomSheetState();
}

class _MultiChoiceBottomSheetState extends State<SuccessBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 70,
            margin: const EdgeInsets.only(
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 12),
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.center,
                  widget.title ?? '',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SvgPicture.asset(widget.image ??''),
          const SizedBox(height: 24),
          Text(
            textAlign: TextAlign.center,
            widget.desc ?? '',
            style: const TextStyle(
                fontSize: 14),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Button action here
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue, // Text color
                side: const BorderSide(color: Colors.blue, width: 1.0), // Blue border
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(widget.buttonText ?? ""),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
