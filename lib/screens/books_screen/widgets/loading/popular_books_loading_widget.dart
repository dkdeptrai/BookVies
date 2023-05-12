import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:flutter/material.dart';

class PopularBooksLoadingWidget extends StatelessWidget {
  const PopularBooksLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              6,
              (index) => ShimmerLoadingWidget(
                  width: size.width / 3,
                  height: size.height * 0.21,
                  margin: const EdgeInsets.only(
                      right: AppDimensions.popularBookItemRightMargin))),
        ));
  }
}
