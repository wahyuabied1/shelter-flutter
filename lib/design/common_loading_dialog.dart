import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shelter_super_app/app/theme_extensions.dart';

class LoadingDialog extends StatelessWidget {
  static OverlayEntry _createOverlayEntry(
    BuildContext context,
    String? message,
    EdgeInsetsGeometry? margin,
    double? width,
  ) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: CommonLoadingWidget(
          message: message,
          margin: margin,
          width: width,
        ),
      ),
    );
  }

  static OverlayEntry? _loadingOverlay;

  const LoadingDialog({super.key});

  /// Shows a loading dialog using an OverlayEntry
  static Future<void> showLoadingDialog(
    BuildContext context, {
    String? message,
    EdgeInsetsGeometry? margin,
    double? width,
  }) async {
    return showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CommonLoadingWidget(
          message: message,
          margin: margin,
          width: width,
          elevation: 0,
        );
      },
    );
  }

  /// Hides the loading dialog by removing the OverlayEntry
  static void hideLoadingDialog(BuildContext context) {
    if (_loadingOverlay != null) {
      _loadingOverlay?.remove();
      _loadingOverlay = null;
    }
  }

  /// Runs a block of code with a loading dialog shown
  static Future<T> runWithLoading<T>(
    BuildContext context,
    Future<T> Function() block, {
    String? message,
    EdgeInsetsGeometry? margin,
    double? width,
  }) async {
    if (_loadingOverlay == null) {
      _loadingOverlay = _createOverlayEntry(context, message, margin, width);
      Overlay.of(context).insert(_loadingOverlay!);
    }

    try {
      final result = await block();
      return result;
    } finally {
      // ignore: use_build_context_synchronously
      hideLoadingDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CommonLoadingWidget(
      elevation: 0,
    );
  }
}

class CommonLoadingWidget extends StatelessWidget {
  final String? message;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? elevation;

  const CommonLoadingWidget({
    super.key,
    this.message,
    this.margin,
    this.width,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(elevation ?? 0.5),
      child: Center(
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.theme.dialogBackgroundColor,
          ),
          width: width ?? 140,
          height: 140,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                strokeWidth: 4.0, // Adjust the thickness of the loader
              ),
              Text(
                message ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue.shade700
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
