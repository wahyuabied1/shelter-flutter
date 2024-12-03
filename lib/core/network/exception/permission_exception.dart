abstract class PermissionException implements Exception {
  final String? message;

  /// The duration that was exceeded.
  PermissionException({
    this.message = 'Akses tidak diizinkan',
  });

  @override
  String toString() {
    String result = 'PermissionException';
    if (message != null) result = '$result: $message';
    return result;
  }
}

class LocationDisableException extends PermissionException {
  LocationDisableException() : super(message: '''
Akses lokasi tidak aktif, silahkan aktifkan lokasi''');

  @override
  String toString() {
    String result = 'LocationDisableException';
    if (message != null) result = '$result: $message';
    return result;
  }
}

class LocationDeniedForeverException extends PermissionException {
  LocationDeniedForeverException() : super(message: '''
Akses lokasi tidak diizinkan,silahkan izinkan lokasi untuk melanjutkan''');

  @override
  String toString() {
    String result = 'LocationDeniedForeverException';
    if (message != null) result = '$result: $message';
    return result;
  }
}

class LocationDeniedException extends PermissionException {
  LocationDeniedException() : super(message: '''
Akses lokasi tidak diizinkan,silahkan izinkan lokasi untuk melanjutkan''');

  @override
  String toString() {
    String result = 'LocationDeniedException';
    if (message != null) result = '$result: $message';
    return result;
  }
}
