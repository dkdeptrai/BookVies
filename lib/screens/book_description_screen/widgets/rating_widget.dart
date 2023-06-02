import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingWidget extends StatelessWidget {
  final String rating;
  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyTextColor),
        boxShadow: [AppStyles.primaryShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SvgPicture.asset(
            AppAssets.icStar,
            height: 20,
            width: 20,
          ),
        ],
      ),
    );
  }
}
