import 'package:bookvies/common_widgets/expandable_text.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/book_description_screen/book_description_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LibraryReviewItemWidget extends StatelessWidget {
  final String mediaType;
  final Review review;
  const LibraryReviewItemWidget(
      {super.key, required this.mediaType, required this.review});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BookDescriptionScreen.id,
            arguments: review.mediaId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: AppDimensions.defaultBorderRadius,
            color: AppColors.secondaryColor,
            boxShadow: [AppStyles.tertiaryShadow]),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CachedNetworkImage(
              imageUrl: review.mediaImage ?? "",
              width: size.width * 0.13,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                  color: AppColors.greyTextColor,
                  width: size.width * 0.13,
                  height: size.width * 0.2)),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(review.mediaName ?? "",
                  style: AppStyles.libraryReviewBookName),
              Text(review.mediaAuthor ?? "",
                  style: AppStyles.libraryReviewAuthor),
              const SizedBox(height: 20),
              Text(review.title, style: AppStyles.smallSemiBoldText),
              Row(
                children: [
                  ...List.generate(
                      review.rating,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: SvgPicture.asset(AppAssets.icRatingStar),
                          )),
                  ...List.generate(
                      5 - review.rating,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child:
                                SvgPicture.asset(AppAssets.icRatingStarOutline),
                          )),
                ],
              ),
              const SizedBox(height: 7),
              SizedBox(
                  width: size.width * 0.63,
                  child: ExpandableText(
                      text: review.description,
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      style: AppStyles.descriptionReviewContent)),
            ],
          )
        ]),
      ),
    );
  }
}
