import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class HighestRatingBookLoadingWidget extends StatelessWidget {
  const HighestRatingBookLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerLoadingWidget(
      height: 120,
      margin: EdgeInsets.only(right: 20, top: 20),
    );
  }
}
