import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/rating_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopRatingBookWidget extends StatelessWidget {
  const TopRatingBookWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Book book = Book.bookList[0];

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
              Text(book.author,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryTextColor)),
              const SizedBox(
                height: 20,
              ),
              const RatingBadge()
            ],
          ),
        ),
        Positioned(
          left: 30,
          // top: -50,
          child: Container(
            decoration: BoxDecoration(boxShadow: [AppStyles.tertiaryShadow]),
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
}
