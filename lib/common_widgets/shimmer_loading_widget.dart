import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  const ShimmerLoadingWidget(
      {super.key, this.height, this.width, this.borderRadius, this.margin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.baseShimmerLoadingColor,
        highlightColor: AppColors.highlightShimmerLoadingColor,
        child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius ?? AppDimensions.defaultBorderRadius,
          ),
        ));
  }
}
