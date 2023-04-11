import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/books_section_header.dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_item_widget.dart';
import 'package:flutter/material.dart';

class ExploreBooksWidget extends StatelessWidget {
  const ExploreBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          BooksSectionHeader(
            title: "Explore",
            onPressed: () {},
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2 / 2.7),
              shrinkWrap: true,
              itemCount: Book.bookList.length,
              itemBuilder: (context, index) {
                return ExploreBookItemWidget(book: Book.bookList[index]);
              })
        ],
      ),
    );
  }
}
