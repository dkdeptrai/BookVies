import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';

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
      {required String bookId, required String type}) async {
    final libraryRef =
        usersRef.doc(currentUser?.uid).collection("library").doc();

    final libraryItem = {
      "mediaId": bookId,
      "type": convertToCamelCase(type),
      "addedAt": DateTime.now(),
    };

    await libraryRef.set(libraryItem);
  }
}
