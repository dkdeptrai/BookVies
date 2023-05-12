import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  const SectionHeader(
      {super.key, required this.title, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.sectionHeaderText),
          IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset(AppAssets.icArrowRight))
        ],
      ),
    );
  }
}
