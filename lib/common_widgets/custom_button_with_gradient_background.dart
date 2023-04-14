// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';

class CustomButtonWithGradientBackground extends StatelessWidget {
  const CustomButtonWithGradientBackground({
    Key? key,
    this.margin,
    required this.height,
    this.width = double.infinity,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final EdgeInsetsGeometry? margin;
  final double height;
  final double width;
  final String text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: AppStyles.authenticateButtonTextStyle,
        ),
      ),
    );
  }
}
