import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient =
      LinearGradient(colors: [Color(0xFF6FE3E1), Color(0xFF5257E5)]);
  static LinearGradient topRatingBookBackgroundGradient =
      LinearGradient(colors: [
    const Color(0xFF6FE3E1).withOpacity(0.5),
    const Color(0xFF5257E5).withOpacity(0.5)
  ]);
  static LinearGradient secondaryGradient =
      const LinearGradient(colors: [Color(0xFFE36FD7), Color(0xFFE5526C)]);

  static const Color primaryBackgroundColor = Color(0xFFF9F9F9);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF323945);
  static const Color greyTextColor = Color(0xFFCCCCCC);
  static Color primaryHintTextColor = const Color(0xFFCCCCCC).withOpacity(0.6);
  static const Color authenticationSmallTextColor = Color(0xFF6FE3E1);
  static Color primaryShadowColor = const Color(0xFF5A6CEA).withOpacity(0.07);
  static Color secondaryShadowColor = const Color(0xFF000000).withOpacity(0.25);
  static Color inputFieldBorderColor = primaryHintTextColor;
  static Color baseShimmerLoadingColor = Colors.grey[300]!;
  static Color highlightShimmerLoadingColor = Colors.grey[100]!;
  static Color mediumBlue = const Color(0xFF609DE3);
  static Color firstChartColor = const Color(0xFF4EFFEF);
  static Color secondChartColor = const Color(0xFF73A6AD);
  static Color thirdChartColor = const Color(0xFF9B97B2);
  static Color fourthChartColor = const Color(0xFFD8A7CA);
  static Color fifthChartColor = const Color(0xFFC7B8EA);

  static const navBarActiveColor = Color(0xFFFfFFFF);
  static const navBarInactiveColor = greyTextColor;
}
