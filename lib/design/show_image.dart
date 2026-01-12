
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';

Future<void> showImage(
    BuildContext context,
    String contentUri,
    ) async {
  final permission = await PhotoManager.requestPermissionExtend();
  if (!permission.hasAccess) {
    await PhotoManager.openSetting();
    return;
  }

  final String id = contentUri.split('/').last;

  final AssetEntity? asset = await AssetEntity.fromId(id);
  if (asset == null) {
    debugPrint('Asset not found');
    return;
  }

  final Uint8List? bytes = await asset.originBytes;
  if (bytes == null) {
    debugPrint('Failed to load image bytes');
    return;
  }

  if (!context.mounted) return;

  // 5️⃣ Open fullscreen PhotoView
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: PhotoView(
          imageProvider: MemoryImage(bytes),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
        ),
      ),
    ),
  );
}