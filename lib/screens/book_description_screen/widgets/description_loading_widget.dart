import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:flutter/material.dart';

class DescriptionLoadingWidget extends StatelessWidget {
  const DescriptionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              const ShimmerLoadingWidget(height: 150, width: 110),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ShimmerLoadingWidget(height: 30, width: 130),
                    const SizedBox(height: 16),
                    ShimmerLoadingWidget(
                        height: 30,
                        width: 70,
                        borderRadius: BorderRadius.circular(100)),
                    const SizedBox(height: 16),
                    const ShimmerLoadingWidget(height: 20, width: 80),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          const ShimmerLoadingWidget(height: 20),
          const SizedBox(height: 10),
          const ShimmerLoadingWidget(height: 20),
          const SizedBox(height: 10),
          const ShimmerLoadingWidget(height: 20),
          const SizedBox(height: 10),
          const ShimmerLoadingWidget(height: 20),
          const SizedBox(height: 10),
          const ShimmerLoadingWidget(height: 20),
          const SizedBox(height: 50),
          const ShimmerLoadingWidget(height: 300),
        ],
      ),
    );
  }
}
