import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> requestStorage();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<bool> requestStorage() async {
    if (!Platform.isAndroid) return true;

    // Android 13+ (Photos)
    if (await Permission.photos.isGranted) {
      return true;
    }

    // Android < 13
    if (await Permission.storage.isGranted) {
      return true;
    }

    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
