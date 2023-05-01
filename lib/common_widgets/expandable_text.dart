import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  const ExpandableText(
      {super.key,
      required this.text,
      required this.maxLines,
      this.style,
      this.textAlign});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          textAlign: widget.textAlign,
          maxLines: isExpanded ? null : 5,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
          style: widget.style,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            children: [
              Text(
                isExpanded ? "Show less" : "Read more",
                style: TextStyle(color: AppColors.mediumBlue),
              ),
              SvgPicture.asset(
                isExpanded ? AppAssets.icChevronUp : AppAssets.icChevronDown,
                height: 18,
                colorFilter:
                    ColorFilter.mode(AppColors.mediumBlue, BlendMode.srcIn),
              )
            ],
          ),
        )
      ],
    );
  }
}
