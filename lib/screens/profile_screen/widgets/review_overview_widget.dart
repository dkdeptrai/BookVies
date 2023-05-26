import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewOverviewWidget extends StatelessWidget {
  const ReviewOverviewWidget({super.key, required this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            AppStyles.primaryShadow,
          ],
        ),
        child: Row(
          children: [
            Image(
              image: NetworkImage(review.mediaImage!),
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              // Wrap the Column with Flexible
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.mediaName!,
                    style: AppStyles.bookNameForDescriptionHeader,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        review.rating.toString(),
                        style: AppStyles.subHeaderTextStyle,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        AppAssets.icStar,
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                  Text(
                    review.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    review.description,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
