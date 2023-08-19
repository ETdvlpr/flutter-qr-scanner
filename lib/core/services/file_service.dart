import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FileService {
  final picker = ImagePicker();

  Future<File?> selectFile({ImageSource? source}) async {
    if (source == null) {
      source = await getImageSource();
      if (source == null) return null;
    }
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<ImageSource?> getImageSource() async {
    return await Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a Picture'),
                    onTap: () => Get.back(result: ImageSource.camera),
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from Gallery'),
                    onTap: () => Get.back(result: ImageSource.gallery),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
