import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle authenticationHeader = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: "Poppins",
    color: AppColors.primaryTextColor,
  );

  static TextStyle hintTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins",
    color: AppColors.primaryHintTextColor,
  );

  static const TextStyle authenticateButtonTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryColor,
  );

  static OutlineInputBorder authenticateFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: const Color(0xFFCCCCCC).withOpacity(0.6),
    ),
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
}
