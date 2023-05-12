import 'package:bookvies/common_widgets/common_dialog.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showSnackBar(
    {required BuildContext context, required String message, Widget? icon}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      if (icon != null) icon,
      Text(message),
    ],
  )));
}

void showWarningDialog(
    {required BuildContext context, required String message}) {
  showDialog(
      context: context,
      builder: (context) {
        return CommonDialog(
            message: message, icon: Lottie.asset(AppAssets.lottieWarning));
      });
}

void showErrorDialog({required BuildContext context, required String message}) {
  showDialog(
      context: context,
      builder: (context) {
        return CommonDialog(
            message: message, icon: Lottie.asset(AppAssets.lottieError));
      });
}

void showSuccessDialog(
    {required BuildContext context, required String message}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return CommonDialog(
            message: message, icon: Lottie.asset(AppAssets.lottieSuccess));
      });
}

String convertToCamelCase(String text) {
  String result = "";

  final words = text.split(" ");

  for (int i = 0; i < words.length; i++) {
    String word = words[i].toLowerCase();
    if (i == 0) {
      result += word[0] + word.substring(1).toLowerCase();
    } else {
      result += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
  }

  return result;
}

String dateInSlashSplittingFormat(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String durationFromMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;

  return "${hours}h ${remainingMinutes}min";
}
