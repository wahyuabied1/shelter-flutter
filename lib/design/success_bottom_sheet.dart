import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SuccessBottomSheet extends StatefulWidget {
  final String? image;
  final String? title;
  final String? desc;
  final String? buttonTextPrimary;
  final Function? actionTextPrimary;
  final String? buttonText;

  const SuccessBottomSheet({
    super.key,
    this.image,
    this.title,
    this.desc,
    this.buttonTextPrimary,
    this.actionTextPrimary,
    this.buttonText,
  });

  @override
  State<SuccessBottomSheet> createState() => _MultiChoiceBottomSheetState();
}

class _MultiChoiceBottomSheetState extends State<SuccessBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
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
          SvgPicture.asset(widget.image ?? ''),
          const SizedBox(height: 24),
          Text(
            textAlign: TextAlign.center,
            widget.desc ?? '',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    child: Text(
                      "Kembali",
                      style: TextStyle(color: Colors.blue.shade700),
                    ),
                  ),
                ),
              ),
              widget.buttonTextPrimary != null
                  ? const SizedBox(
                      width: 16,
                    )
                  : SizedBox(),
              widget.buttonTextPrimary != null
                  ? Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.actionTextPrimary?.call();
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                          ),
                          child: Text(
                            widget.buttonTextPrimary ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
