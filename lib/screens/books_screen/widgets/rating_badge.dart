import 'package:bookvies/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "4.7",
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(AppAssets.icRatingStar)
        ],
      ),
    );
  }
}
