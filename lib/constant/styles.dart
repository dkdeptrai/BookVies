import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';

class AppStyle {
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
}