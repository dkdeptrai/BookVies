import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final List<String> reportTitles = [
    "Inappropriate Language",
    "Misleading Information",
    "Sensitive Content",
    "Racism Or Discrimination",
    "Others"
  ];
  int selectedReportIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        decoration: BoxDecoration(
            color: AppColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(28)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppAssets.icReport),
                const Text(
                  "Report this review",
                  style: AppStyles.reportDialogTitle,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(AppAssets.icClose))
              ],
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("What is wrong about this review?",
                  style: AppStyles.reportSectionTitle),
            ),
            ...List.generate(
                reportTitles.length,
                (index) => Row(
                      children: [
                        Checkbox(
                            shape: const CircleBorder(),
                            checkColor: Colors.transparent,
                            activeColor: AppColors.mediumBlue,
                            value: selectedReportIndex == index,
                            onChanged: (isCheck) {
                              setState(() {
                                selectedReportIndex = index;
                              });
                            }),
                        Text(reportTitles[index])
                      ],
                    )),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Description", style: AppStyles.reportSectionTitle),
            ),
            const SizedBox(height: 15),
            TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: AppColors.secondaryColor,
                  focusColor: AppColors.secondaryColor,
                  filled: true,
                  hintText:
                      "Please provide us more details so we can know what happened",
                  hintStyle:
                      AppStyles.writeReviewHintText.copyWith(height: 1.4),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),
                )),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: CustomButtonWithGradientBackground(
                  width: 200,
                  gradient: AppColors.secondaryGradient,
                  height: 50,
                  text: "Report",
                  onPressed: () {
                    // TODO: Add report to fb
                  }),
            )
          ],
        ));
  }
}
