import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BooksSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const BooksSectionHeader({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.booksSectionHeaderText),
        IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(AppAssets.icArrowRight))
      ],
    );
  }
}
