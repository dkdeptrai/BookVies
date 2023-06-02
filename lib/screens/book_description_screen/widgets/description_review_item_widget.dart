import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/common_widgets/expandable_text.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/comment_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/report_dialog.dart';
import 'package:bookvies/screens/profile_screen/profile_screen.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DescriptionReviewItemWidget extends StatefulWidget {
  final Review review;
  final bool hasComments;
  const DescriptionReviewItemWidget(
      {super.key, required this.review, this.hasComments = false});

  @override
  State<DescriptionReviewItemWidget> createState() =>
      _DescriptionReviewItemWidgetState();
}

class _DescriptionReviewItemWidgetState
    extends State<DescriptionReviewItemWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showCommentDialog(context),
      child: Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.defaultPadding),
          padding: const EdgeInsets.all(AppDimensions.defaultPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: AppColors.secondaryColor,
              boxShadow: [AppStyles.secondaryShadow]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(widget.review.userAvatarUrl)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.review.userName,
                          style: AppStyles.descriptionReviewUserName),
                      Row(
                        children: [
                          ...List.generate(
                              widget.review.rating,
                              (index) => SvgPicture.asset(AppAssets.icStar,
                                  height: 12)),
                          ...List.generate(
                              5 - widget.review.rating,
                              (index) => SvgPicture.asset(
                                  AppAssets.icRatingStarOutline,
                                  height: 12)),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => showReportDialog(context),
                      icon: SvgPicture.asset(AppAssets.icReport)),
                  IconButton(
                      onPressed: () {
                        // TODO: share review
                      },
                      icon: SvgPicture.asset(AppAssets.icShareGradient))
                ],
              ),
              const SizedBox(height: 8),
              Text(widget.review.title,
                  style: AppStyles.descriptionReviewTitle),
              ExpandableText(
                  text: widget.review.description,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  style: AppStyles.descriptionReviewContent),
              BlocBuilder<DescriptionReviewListBloc,
                  DescriptionReviewListState>(
                builder: (context, state) {
                  if (state is DescriptionReviewListLoaded) {
                    final review = state.reviews.firstWhere(
                        (element) => element.id == widget.review.id);

                    return Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context
                                  .read<DescriptionReviewListBloc>()
                                  .add(UpVote(reviewId: widget.review.id));
                            },
                            icon: review.upVoteUsers.contains(currentUser!.uid)
                                ? SvgPicture.asset(AppAssets.icUpVoteFill)
                                : SvgPicture.asset(AppAssets.icUpVoteOutline)),
                        Text("${review.upVoteNumber}",
                            style: AppStyles.smallSemiBoldText),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<DescriptionReviewListBloc>()
                                  .add(DownVote(reviewId: widget.review.id));
                            },
                            icon:
                                review.downVoteUsers.contains(currentUser!.uid)
                                    ? SvgPicture.asset(AppAssets.icDownVoteFill)
                                    : SvgPicture.asset(
                                        AppAssets.icDownVoteOutline)),
                        Text("${review.downVoteNumber}",
                            style: AppStyles.smallSemiBoldText),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              if (!widget.hasComments) {
                                _showCommentDialog(context);
                              }
                            },
                            icon: SvgPicture.asset(AppAssets.icComment)),
                        const Text("Comment",
                            style: AppStyles.smallSemiBoldText),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),

              // Comment box
              if (widget.hasComments)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: _commentController,
                              maxLength: 150,
                              maxLines: 5,
                              minLines: 1,
                              buildCounter: (_,
                                      {currentLength = 0,
                                      isFocused = false,
                                      maxLength}) =>
                                  Text("$currentLength/$maxLength"),
                              style: AppStyles.writeReviewContentText,
                              decoration: InputDecoration(
                                  hintText: "Write a comment",
                                  hintStyle: AppStyles.writeReviewHintText,
                                  contentPadding: const EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumBlue),
                                      borderRadius:
                                          AppDimensions.defaultBorderRadius),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumBlue),
                                      borderRadius:
                                          AppDimensions.defaultBorderRadius))),
                        ),
                        IconButton(
                            onPressed: _comment,
                            icon: SvgPicture.asset(AppAssets.icMessage,
                                height: 30, width: 30))
                      ],
                    ),

                    // Comment list
                    BlocBuilder<DescriptionReviewListBloc,
                        DescriptionReviewListState>(
                      builder: (context, state) {
                        if (state is DescriptionReviewListLoaded) {
                          final Review review = state.reviews.firstWhere(
                              (element) => element.id == widget.review.id);

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: review.comments.length,
                              itemBuilder: (_, index) {
                                final comment = review.comments[index];
                                return CommentWidget(comment: comment);
                              });
                        }
                        return Container();
                      },
                    )
                  ],
                )
            ],
          )),
    );
  }

  void _comment() {
    if (_commentController.text.isNotEmpty) {
      BlocProvider.of<DescriptionReviewListBloc>(context).add(AddCommentEvent(
          context: context,
          reviewId: widget.review.id,
          mediaId: widget.review.mediaId,
          comment: _commentController.text));

      _commentController.clear();
    }
  }

  void _showCommentDialog(BuildContext context) {
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
                    review: widget.review,
                    hasComments: true,
                  )
                ]),
              ),
            ));
  }

  void showReportDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(children: const [ReportDialog()]),
            ),
          );
        });
  }
}
