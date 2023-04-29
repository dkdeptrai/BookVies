import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/library_screen/widgets/library_book_item_widget.dart';
import 'package:flutter/material.dart';

class BookToReadTab extends StatelessWidget {
  const BookToReadTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = Book.bookList[0];

    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return LibraryBookItemWidget(book: book);
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 10);
        },
        itemCount: 5);
  }
}
