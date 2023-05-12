import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';

class LibraryService {
  static Future<bool> isThisBookInLibrary(String bookId) async {
    final items = await usersRef
        .doc(currentUser?.uid)
        .collection("library")
        .where("mediaId", isEqualTo: bookId)
        .get();

    return items.docs.isNotEmpty;
  }

  static Future<void> addToLibrary(
      {required String mediaId,
      required String image,
      required String name,
      required String author,
      required String status}) async {
    final libraryRef =
        usersRef.doc(currentUser?.uid).collection("library").doc();

    final libraryItem = {
      "mediaId": mediaId,
      "image": image,
      "name": name,
      "author": author,
      "status": status,
      "addedAt": DateTime.now(),
    };

    await libraryRef.set(libraryItem);
  }

  Future<void> updateBookStatus(
      BuildContext context, String bookId, String newStatus) async {
    print(bookId);
    try {
      await usersRef
          .doc(currentUser?.uid)
          .collection("library")
          .doc(bookId)
          .update({"status": newStatus});
    } catch (error) {
      showErrorDialog(context: context, message: "Something went wrong");
      print("Update book status error: $error");
    }
  }
}
