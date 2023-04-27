import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/books_section_header.dart';
import 'package:bookvies/screens/books_screen/widgets/popular_book_item_widget.dart';
import 'package:bookvies/screens/popular_book_screen/popular_book_screen.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:flutter/material.dart';

class PopularBookWidget extends StatelessWidget {
  final EdgeInsets? margin;
  const PopularBookWidget({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    // final List<Book> books = Book.bookList;

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BooksSectionHeader(
            title: "Popular Books",
            onPressed: () => _navigateToPopularBookScreen(context),
          ),
          FutureBuilder<List<Book>>(
              future: _getPopularBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  final List<Book> books = snapshot.data!;
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(books.length,
                            (index) => PopularBookItem(book: books[index])),
                      ));
                }
              })
        ],
      ),
    );
  }

  _navigateToPopularBookScreen(BuildContext context) {
    Navigator.pushNamed(context, PopularBookScreen.id);
  }

  Future<List<Book>> _getPopularBooks() {
    return BookService().getPopularBooks();
  }
}
