import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();

  try {
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 85, // compress to 85% quality
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  } catch (e) {
    debugPrint("Error picking image: $e");
  }

  return null;
}

Future<File?> showPickerOptions(BuildContext context) async {
  return showModalBottomSheet<File>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              Navigator.pop(context, await pickImage(ImageSource.gallery));
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () async {
              Navigator.pop(context, await pickImage(ImageSource.camera));
            },
          ),
        ],
      ),
    ),
  );
}
