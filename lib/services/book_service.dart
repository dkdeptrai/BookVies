import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class BookService {
  Future<List<Book>> getPopularBooks({required int limit}) async {
    List<Book> books = [];

    final ref = await booksRef
        .orderBy("averageRating", descending: true)
        .limit(limit)
        .get();

    ref.docs.forEach(
        (item) => books.add(Book.fromMap(item.data() as Map<String, dynamic>)));

    return books;
  }
}
