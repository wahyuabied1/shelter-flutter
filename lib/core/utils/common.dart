import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> retry<T>(int times, FutureOr<T> Function() callback) async {
  var attempt = 0;
  while (true) {
    attempt++;
    try {
      await callback();
      return;
    } on Exception catch (_) {
      if (attempt >= times) {
        rethrow;
      }
    }
    await Future.delayed(const Duration(microseconds: 200));
  }
}

Future saveToGallery(String url) async {
  final now = DateTime.now();
  final formatted = "${now.year}"
      "${now.month.toString().padLeft(2, '0')}"
      "${now.day.toString().padLeft(2, '0')}_"
      "${now.hour.toString().padLeft(2, '0')}"
      "${now.minute.toString().padLeft(2, '0')}"
      "${now.second.toString().padLeft(2, '0')}";

  final fileName = "shelter_image_$formatted";

  var response = await Dio().get(
    url,
    options: Options(responseType: ResponseType.bytes),
  );

  final result = await ImageGallerySaver.saveImage(
    Uint8List.fromList(response.data),
    quality: 100,
    name: fileName,
  );

  return result;
}

