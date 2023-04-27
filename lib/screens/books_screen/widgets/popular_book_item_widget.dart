import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/rating_badge.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularBookItem extends StatelessWidget {
  const PopularBookItem({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(book.image);

    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          Container(
              width: size.width / 3,
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 10, bottom: 15),
              decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  boxShadow: [AppStyles.primaryShadow],
                  borderRadius: AppDimensions.defaultBorderRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: book.image,
                        height: 80,
                        fit: BoxFit.cover,
                        errorWidget: (context, index, error) =>
                            const Icon(Icons.error),
                      ),
                      RatingBadge(
                        rating: book.averageRating,
                        borderColor: AppColors.greyTextColor,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    book.name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    book.author.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyTextColor),
                  ),
                  const SizedBox(height: 20),
                ],
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {},
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      gradient: AppColors.primaryGradient),
                  child: const Text("Details",
                      style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500))),
            ),
          )
        ],
      ),
    );
  }
}
