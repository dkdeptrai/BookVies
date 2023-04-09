import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle authenticationHeader = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );

  static Shadow primaryShadow = Shadow(
    color: AppColors.primaryShadowColor,
    offset: const Offset(12, 26),
    blurRadius: 40,
  );

  static Shadow secondaryShadow = Shadow(
      color: AppColors.secondaryShadowColor,
      offset: const Offset(0, 10),
      blurRadius: 30);

  static const actionBarText = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w600);
}
