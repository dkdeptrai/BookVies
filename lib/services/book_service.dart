import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class BookService {
  Future<List<Book>> getPopularBooks({required int limit}) async {
    List<Book> books = [];

    final ref = await booksRef
        // .orderBy("averageRating", descending: true)
        .limit(limit)
        .get();

    ref.docs.forEach((item) {
      Book book = Book.fromMap(item.data() as Map<String, dynamic>);
      book.id = item.id;
      books.add(book);
    });

    return books;
  }

  Future<List<Book>> searchBooks(
      {required String keyword, required int limit}) async {
    List<Book> books = [];

    print(keyword);

    final ref = await booksRef
        .orderBy('name')
        // .where('name', isGreaterThanOrEqualTo: keyword)
        // .where('name', isLessThan: keyword + 'z')
        .startAt([keyword])
        .endAt([keyword + '\uf8ff'])
        .limit(10)
        .get();

    print(ref.docs.length);

    ref.docs.forEach(
        (item) => books.add(Book.fromMap(item.data() as Map<String, dynamic>)));

    return books;
  }

  Future<void> updateKeywordsField() async {
    final snapshot = await booksRef.get();

    snapshot.docs.forEach((item) {
      final book = Book.fromMap(item.data() as Map<String, dynamic>);

      final String bookName = book.name;
      List<String> keywords = [];
      String keyword = "";

      for (int i = 0; i < bookName.length; i++) {
        keyword += bookName[i];
        keywords.add(keyword);
      }

      booksRef.doc(item.id).update({'keywords': keywords});
    });
  }
}
