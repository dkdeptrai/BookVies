import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient =
      LinearGradient(colors: [Color(0xFF6FE3E1), Color(0xFF5257E5)]);
  static LinearGradient topRatingBookBackgroundGradient =
      LinearGradient(colors: [
    const Color(0xFF6FE3E1).withOpacity(0.5),
    const Color(0xFF5257E5).withOpacity(0.5)
  ]);

  static const Color primaryBackgroundColor = Color(0xFFF9F9F9);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF323945);
  static const Color greyTextColor = Color(0xFFCCCCCC);
  static Color primaryHintTextColor = const Color(0xFFCCCCCC).withOpacity(0.6);
  static const Color authenticationSmallTextColor = Color(0xFF6FE3E1);
  static Color primaryShadowColor = const Color(0xFF5A6CEA).withOpacity(0.07);
  static Color secondaryShadowColor = const Color(0xFF000000).withOpacity(0.25);

  static const navBarActiveColor = Color(0xFFFfFFFF);
  static const navBarInactiveColor = greyTextColor;
}
