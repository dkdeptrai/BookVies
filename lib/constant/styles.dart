import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

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
  static const TextStyle smallSemiBoldText = TextStyle(
      fontSize: 12,
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w600);

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

  static const actionBarText = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w600);

  static const sectionHeaderText = TextStyle(
      fontSize: 20,
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w500);
  static const descriptionItemText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor,
  );
  static const primaryTextStyle = TextStyle(
    fontSize: 12,
    color: AppColors.primaryTextColor,
  );

  static const bookNameForDescriptionHeader = TextStyle(
    fontSize: 20,
    color: AppColors.primaryTextColor,
    fontWeight: FontWeight.w600,
  );

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

  static const writeReviewSectionTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const reportSectionTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const writeReviewHintText = TextStyle(
      height: 1,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor);

  static const writeReviewContentText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryTextColor);

  static const commentUserNameText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor);

  static const commentContentText =
      TextStyle(fontSize: 12, color: AppColors.primaryTextColor);

  static const descriptionReviewUserName = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor);

  static const descriptionReviewTitle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor);

  static const descriptionReviewContent = TextStyle(
    fontSize: 12,
    color: AppColors.primaryTextColor,
  );

  static const chartText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
  );

  static const libraryReviewBookName = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor);

  static const libraryReviewAuthor =
      TextStyle(fontSize: 12, color: AppColors.greyTextColor);

  static const libraryFavoritesSectionHeader =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

  static const reportDialogTitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static const adminHeader = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryTextColor);

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

  static BoxDecoration primaryNoBorderBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [AppStyles.primaryShadow],
    color: AppColors.secondaryColor,
  );

  static OutlineInputBorder chatInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: AppColors.mediumBlue,
    ),
  );

  static BoxDecoration chatMessageDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [AppStyles.primaryShadow],
    color: Colors.transparent,
    border: const GradientBoxBorder(
        gradient: AppColors.primaryGradient,
        width: 2), // Set a solid border color and width
  );
}
