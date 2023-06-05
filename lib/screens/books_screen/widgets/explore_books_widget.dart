import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_item_widget.dart';
import 'package:bookvies/screens/explore_books_screen/explore_books_screen.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExploreBooksWidget extends StatelessWidget {
  const ExploreBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          SectionHeader(
            title: "Explore",
            onPressed: () => _navigateToExploreBooksScreen(context),
          ),
          FutureBuilder(
              future: _getExploreBooks(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitFadingCircle(color: AppColors.mediumBlue));
                }

                final books = snapshot.data!;
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(right: 20, bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.74),
                    shrinkWrap: true,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return ExploreBookItemWidget(book: books[index]);
                    });
              }),
        ],
      ),
    );
  }

  _navigateToExploreBooksScreen(BuildContext context) {
    Navigator.pushNamed(context, ExploreBooksScreen.id);
  }

  Future<List<Book>> _getExploreBooks({required BuildContext context}) async {
    List<Book> books = [];
    final result =
        await BookService().getRecommendBooks(context: context, limit: 10);

    return result['books'];
  }
}
