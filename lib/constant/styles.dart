import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle authenticationHeader = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
  );

  static BoxShadow primaryShadow = BoxShadow(
    color: AppColors.primaryShadowColor,
    offset: const Offset(12, 26),
    blurRadius: 40,
  );

  static BoxShadow secondaryShadow = BoxShadow(
      color: AppColors.secondaryShadowColor,
      offset: const Offset(0, 10),
      blurRadius: 30);

  static BoxShadow tertiaryShadow = BoxShadow(
      color: AppColors.secondaryShadowColor,
      offset: const Offset(4, 4),
      blurRadius: 4);

  static const actionBarText = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w600);
}
