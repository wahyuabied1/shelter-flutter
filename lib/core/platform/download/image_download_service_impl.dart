import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'image_download_service.dart';

class ImageDownloadServiceImpl implements ImageDownloadService {
  final Dio _dio;

  ImageDownloadServiceImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<bool> saveToGallery(
    String imageUrl, {
    String? fileName,
  }) async {
    try {
      final response = await _dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: fileName ?? 'IMG_${DateTime.now().millisecondsSinceEpoch}',
      );

      return result['isSuccess'] == true;
    } catch (e) {
      return false;
    }
  }
}
