import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBookItemWidget extends StatelessWidget {
  final Book book;
  const SearchBookItemWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: AppDimensions.defaultBorderRadius,
          color: AppColors.secondaryColor,
          boxShadow: [
            AppStyles.primaryShadow,
          ]),
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: book.image,
          width: 52,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                book.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.searchBookNameText,
              ),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                book.author.toString(),
                style: AppStyles.searchBookAuthorText,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text("Rating: ${book.averageRating}",
                    style: AppStyles.searchBookRatingText),
                SvgPicture.asset(AppAssets.icRatingStar)
              ],
            )
          ],
        )
      ]),
    );
  }
}
