abstract class GeocodingService {
  /// Convert latitude & longitude menjadi alamat readable
  Future<String?> getAddressFromLatLng({
    required double latitude,
    required double longitude,
  });
}
