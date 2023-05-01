import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class WriteReviewScreen extends StatefulWidget {
  final String mediaId;
  const WriteReviewScreen({super.key, required this.mediaId});

  static const id = "/write-review-screen";

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final privacyDropdownValues = ["Public", "Personal"];
  String privacyCurrentValue = "";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    privacyCurrentValue = privacyDropdownValues[0];
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppDimensions.defaultAppBarPreferredSize,
        child: CustomAppBar(
          title: "Write Your Review",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(AppAssets.icArrowLeft)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Title",
                      style: AppStyles.writeReviewSectionTitle,
                    ),
                    DropdownButton<String>(
                        underline: Container(),
                        icon: SvgPicture.asset(AppAssets.icAdjustGradient),
                        value: privacyCurrentValue,
                        alignment: Alignment.centerRight,
                        style: AppStyles.libraryReviewedDropdownText,
                        items: privacyDropdownValues
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              privacyCurrentValue = value;
                            }
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    style: AppStyles.writeReviewContentText,
                    decoration: InputDecoration(
                        hintText: "Enter the title of your review",
                        hintStyle: AppStyles.writeReviewHintText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100))),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Rating",
                      style: AppStyles.writeReviewSectionTitle,
                    ),
                    const SizedBox(width: 20),
                    RatingBar.builder(
                        itemSize: 30,
                        itemBuilder: (_, index) {
                          return SvgPicture.asset(AppAssets.icStar, height: 30);
                        },
                        onRatingUpdate: (value) {
                          setState(() {
                            rating = value;
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Review",
                  style: AppStyles.writeReviewSectionTitle,
                ),
                TextFormField(
                  maxLines: 10,
                  minLines: 4,
                  style: AppStyles.writeReviewContentText,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Write your review",
                      hintStyle: AppStyles.writeReviewHintText,
                      border: OutlineInputBorder(
                          borderRadius: AppDimensions.defaultBorderRadius)),
                ),
                const SizedBox(height: 20),
                CustomButtonWithGradientBackground(
                  height: 53,
                  text: "Submit",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addReview() async {
    // final Review review = Review(
    //     id: "",
    //     userId: currentUser!.uid,
    //     userName: userName,
    //     userAvatarUrl: userAvatarUrl,
    //     mediaId: widget.mediaId,
    //     rating: rating.toInt(),
    //     title: titleController.text,
    //     description: contentController.text,
    //     upVoteNumber: 0,
    //     upVoteUsers: [],
    //     downVoteNumber: 0,
    //     downVoteUsers: [],
    //     comments: [],
    //     createdTime: DateTime.now(),
    //     privacy: privacyCurrentValue.toUpperCase());
  }
}
