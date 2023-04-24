import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/screens/books_screen/widgets/popular_book_item_widget.dart';
import 'package:bookvies/screens/popular_book_screen/popular_book_screen.dart';
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
          SectionHeader(
            title: "Popular Books",
            onPressed: () => _navigateToPopularBookScreen(context),
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

  _navigateToPopularBookScreen(BuildContext context) {
    Navigator.pushNamed(context, PopularBookScreen.id);
  }
}
