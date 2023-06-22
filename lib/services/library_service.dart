import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';

class LibraryService {
  Future<bool> isThisBookInLibrary(String bookId) async {
    final items = await usersRef
        .doc(firebaseAuth.currentUser?.uid)
        .collection("library")
        .where("mediaId", isEqualTo: bookId)
        .get();

    return items.docs.isNotEmpty;
  }

  Future<void> addToLibrary(
      {required String mediaId,
      required String image,
      required String name,
      required Object author,
      required String status}) async {
    final libraryRef =
        usersRef.doc(firebaseAuth.currentUser?.uid).collection("library").doc();

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
    try {
      await usersRef
          .doc(firebaseAuth.currentUser?.uid)
          .collection("library")
          .doc(bookId)
          .update({"status": newStatus});
    } catch (error) {
      showErrorDialog(context: context, message: "Something went wrong");
      print("Update book status error: $error");
    }
  }

  Future<bool> isThisBookInFavorites({required String mediaId}) async {
    final items = await usersRef
        .doc(firebaseAuth.currentUser?.uid)
        .collection("favorites")
        .where("mediaId", isEqualTo: mediaId)
        .get();

    return items.docs.isNotEmpty;
  }

  Future<void> addToFavorites(
      {required String mediaId,
      required String image,
      required String name,
      required Object author,
      required String mediaType}) async {
    final libraryItem = {
      "mediaId": mediaId,
      "image": image,
      "name": name,
      "author": author,
      "addedAt": DateTime.now(),
      "mediaType": mediaType,
    };

    await usersRef
        .doc(firebaseAuth.currentUser?.uid)
        .collection("favorites")
        .add(libraryItem);

    // await libraryRef.set(libraryItem);
  }
}
