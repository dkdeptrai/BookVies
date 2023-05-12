import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';

class CurrentlyAddedBookLoadingWidget extends StatelessWidget {
  const CurrentlyAddedBookLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        ShimmerLoadingWidget(
            margin: const EdgeInsets.only(top: 20),
            height: size.height * 0.3,
            width: size.width * 0.4),
        const SizedBox(height: 36),
        const ShimmerLoadingWidget(height: 30, width: 200),
        const SizedBox(height: 16),
        const ShimmerLoadingWidget(height: 20, width: 300),
      ],
    );
  }
}
