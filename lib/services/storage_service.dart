import 'dart:io';

import 'package:bookvies/utils/firebase_constants.dart';

class StorageService {
  Future<String?> uploadFileToStorage(
      {required String path, required String name}) async {
    final imageRef = storageRef.child("movie_images/$name");
    File file = File(path);
    try {
      await imageRef.putFile(file);
      final String downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
