import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Shadow
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

  // Text
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

  static const TextStyle subHeaderTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
  );
  static const TextStyle authenticateButtonTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryColor,
  );

  static const TextStyle actionBarText = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w600);

  static const sectionHeaderText = TextStyle(
      fontSize: 20,
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w500);

  static const searchBoxText =
      TextStyle(height: 1, fontSize: 12, color: AppColors.greyTextColor);

  static const searchBookNameText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor);

  static const searchBookAuthorText =
      TextStyle(fontSize: 10, color: AppColors.greyTextColor);

  static const searchBookRatingText = TextStyle(
    fontSize: 10,
    color: AppColors.primaryTextColor,
  );
  static const movieItemName = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor);

  static const libraryBookItemAuthorText = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF615555));
  static const libraryBookItemDropdownText = TextStyle(
      fontFamily: "Poppins", fontSize: 12, color: AppColors.primaryTextColor);

  static const libraryReviewedDropdownText = TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black);

  // Others
  static BoxDecoration primaryBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [AppStyles.primaryShadow],
    color: AppColors.secondaryColor,
    border: Border.all(color: const Color(0xFFCCCCCC).withOpacity(0.6)),
  );

  static OutlineInputBorder authenticateFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: const Color(0xFFCCCCCC).withOpacity(0.6),
    ),
  );
}
