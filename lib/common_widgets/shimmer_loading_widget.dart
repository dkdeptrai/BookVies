import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerLoadingWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          height: height,
          width: width,
        ));
  }
}
