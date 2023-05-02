import 'package:bookvies/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChartDetailItemWidget extends StatelessWidget {
  final Color color;
  final int rating;
  final int quantity;
  const ChartDetailItemWidget(
      {super.key,
      required this.color,
      required this.rating,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          color: color,
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            Text(rating.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(width: 5),
            SvgPicture.asset(AppAssets.icStar, height: 14),
            Text(" ($quantity)", style: const TextStyle(fontSize: 12)),
          ],
        )
      ],
    );
  }
}
