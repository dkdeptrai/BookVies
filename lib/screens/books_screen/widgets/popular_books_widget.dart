import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/books_section_header.dart';
import 'package:bookvies/screens/books_screen/widgets/popular_book_item_widget.dart';
import 'package:flutter/material.dart';

class PopularBookWidget extends StatelessWidget {
  final EdgeInsets? margin;
  const PopularBookWidget({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    final List<Book> books = Book.bookList;

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BooksSectionHeader(
            title: "Popular Books",
            onPressed: () {},
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(books.length,
                    (index) => PopularBookItem(book: books[index])),
              ))
        ],
      ),
    );
  }
}
