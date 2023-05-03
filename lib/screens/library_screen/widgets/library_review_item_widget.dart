import 'package:bookvies/common_widgets/expandable_text.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LibraryReviewItemWidget extends StatelessWidget {
  final Review review;
  const LibraryReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final Book book = Book.bookList[0]; // Only need to use Media
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: AppDimensions.defaultBorderRadius,
          color: AppColors.secondaryColor,
          boxShadow: [AppStyles.tertiaryShadow]),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.network(book.image, width: size.width * 0.13, fit: BoxFit.cover),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTextColor)),
            Text(book.author ?? "",
                style: TextStyle(fontSize: 10, color: AppColors.greyTextColor)),
            const SizedBox(height: 20),
            Text(review.title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryTextColor)),
            Row(
              children: [
                ...List.generate(
                    review.rating,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: SvgPicture.asset(AppAssets.icRatingStar),
                        )),
                SvgPicture.asset(AppAssets.icRatingStarOutline)
              ],
            ),
            const SizedBox(height: 7),
            SizedBox(
                width: size.width * 0.63,
                child: ExpandableText(
                    text: review.description,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 12))),
          ],
        )
      ]),
    );
  }
}
