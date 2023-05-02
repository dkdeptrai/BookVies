import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/rating_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DescriptionTitleWidget extends StatelessWidget {
  const DescriptionTitleWidget({
    super.key,
    required this.size,
    required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 58),
      width: size.width - 40,
      decoration: AppStyles.primaryNoBorderBoxDecoration,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppDimensions.defaultBorderRadius,
            child: CachedNetworkImage(
              imageUrl: book.image,
              width: 108,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.name,
                    style: AppStyles.bookNameForDescriptionHeader,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  RatingWidget(
                    rating: book.averageRating,
                  ),
                  const SizedBox(height: 16),
                  Text("${book.numberReviews} Reviews"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
