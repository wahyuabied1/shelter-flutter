abstract class ImageDownloadService {
  Future<bool> saveToGallery(
    String imageUrl, {
    String? fileName,
  });
}
