import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/library_screen/widgets/library_review_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewedTab extends StatefulWidget {
  const ReviewedTab({super.key});

  @override
  State<ReviewedTab> createState() => _ReviewedTabState();
}

class _ReviewedTabState extends State<ReviewedTab> {
  final privacyDropdownValues = ["Public", "Personal"];
  String privacyCurrentValue = "";
  final typeDropdownValues = ["Book", "Movie"];
  String typeCurrentValue = "";

  @override
  void initState() {
    super.initState();
    privacyCurrentValue = privacyDropdownValues[0];
    typeCurrentValue = typeDropdownValues[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                    underline: Container(),
                    icon: SvgPicture.asset(AppAssets.icAdjustGradient),
                    value: typeCurrentValue,
                    alignment: Alignment.centerRight,
                    style: AppStyles.libraryReviewedDropdownText,
                    items: typeDropdownValues
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          typeCurrentValue = value;
                        }
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                    underline: Container(),
                    icon: SvgPicture.asset(AppAssets.icAdjustGradient),
                    value: privacyCurrentValue,
                    alignment: Alignment.centerRight,
                    style: AppStyles.libraryReviewedDropdownText,
                    items: privacyDropdownValues
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
          ),
          StreamBuilder<QuerySnapshot>(
              stream: reviewsRef
                  .where("userId", isEqualTo: currentUser!.uid)
                  .where("privacy",
                      isEqualTo: privacyCurrentValue.toUpperCase())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitFadingCircle(
                    color: AppColors.primaryBackgroundColor,
                  );
                }

                final reviews = snapshot.data!.docs
                    .map(
                        (e) => Review.fromMap(e.data() as Map<String, dynamic>))
                    .toList();
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        bottom: AppDimensions.defaultPadding),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) =>
                        LibraryReviewItemWidget(review: reviews[index]),
                    separatorBuilder: (_, index) => const SizedBox(height: 25),
                    itemCount: reviews.length);
              })
        ],
      ),
    );
  }
}
