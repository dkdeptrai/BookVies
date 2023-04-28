import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/loading/highest_rating_book_loading_widget.dart';
import 'package:bookvies/screens/books_screen/widgets/rating_badge.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HighestRatingBookWidget extends StatelessWidget {
  const HighestRatingBookWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<Book>(
        future: _getMostPopularBook(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HighestRatingBookLoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            final Book book = snapshot.data!;
            return Stack(
              children: [
                Container(
                  width: size.width - 2 * AppDimensions.defaultPadding,
                  padding: const EdgeInsets.fromLTRB(20, 20, 50, 20),
                  margin: const EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                      gradient: AppColors.topRatingBookBackgroundGradient,
                      borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor)),
                      Text(book.author.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryTextColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      RatingBadge(
                        rating: book.averageRating,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  // top: -50,
                  child: Container(
                    decoration:
                        BoxDecoration(boxShadow: [AppStyles.tertiaryShadow]),
                    child: CachedNetworkImage(
                      imageUrl: book.image,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }

  Future<Book> _getMostPopularBook() async {
    final books = await BookService().getPopularBooks(limit: 1);

    return books[0];
  }
}
