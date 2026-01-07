import 'package:flutter/material.dart';

class ListMenuBottomSheet extends StatefulWidget {
  final String? title;
  final List<Widget>? listWidget;

  const ListMenuBottomSheet({
    super.key,
    this.title,
    this.listWidget
  });

  @override
  State<ListMenuBottomSheet> createState() => _ListMenuBottomSheetState();
}

class _ListMenuBottomSheetState extends State<ListMenuBottomSheet> {
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  widget.title ??'',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (widget.listWidget != null)
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: widget.listWidget!,
                ),
              ),
            ),
          const SizedBox(height: 12),

        ],
      ),
    );
  }
}
