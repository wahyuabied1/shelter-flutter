import 'package:geocoding/geocoding.dart';
import 'geocoding_service.dart';

class GeocodingServiceImpl implements GeocodingService {
  @override
  Future<String?> getAddressFromLatLng({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) return null;

      final place = placemarks.first;

      final parts = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
      ].where((e) => e != null && e!.isNotEmpty).toList();

      return parts.join(', ');
    } catch (e) {
      return null;
    }
  }
}
