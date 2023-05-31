import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_review_item_widget.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewOverviewWidget extends StatefulWidget {
  const ReviewOverviewWidget({super.key, required this.review});
  final Review review;

  @override
  State<ReviewOverviewWidget> createState() => _ReviewOverviewWidgetState();
}

class _ReviewOverviewWidgetState extends State<ReviewOverviewWidget> {
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
            GestureDetector(
              onTap: () => _navigateToDescriptionScreen(),
              child: Image(
                image: NetworkImage(widget.review.mediaImage!),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              // Wrap the Column with Flexible
              child: GestureDetector(
                onTap: () => _showCommentDialog(context, widget.review),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.mediaName!,
                      style: AppStyles.bookNameForDescriptionHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.review.rating.toString(),
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
                      widget.review.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.review.description,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (widget.review.upVoteNumber -
                                widget.review.downVoteNumber >=
                            0)
                          SvgPicture.asset(AppAssets.icUpVoteFill)
                        else
                          SvgPicture.asset(AppAssets.icDownVoteFill),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          (widget.review.upVoteNumber -
                                  widget.review.downVoteNumber)
                              .toString(),
                          style: AppStyles.subHeaderTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToDescriptionScreen() async {
    GlobalMethods().navigateToDescriptionScreen(
      context: context,
      mediaId: widget.review.mediaId,
      mediaType: widget.review.mediaType,
    );
  }

  void _showCommentDialog(BuildContext context, Review review) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(20),
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  DescriptionReviewItemWidget(
                    review: review,
                    hasComments: true,
                  )
                ]),
              ),
            ));
  }
}
