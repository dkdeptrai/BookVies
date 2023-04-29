import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LibraryBookItemWidget extends StatefulWidget {
  final Book book;
  const LibraryBookItemWidget({super.key, required this.book});

  @override
  State<LibraryBookItemWidget> createState() => _LibraryBookItemWidgetState();
}

class _LibraryBookItemWidgetState extends State<LibraryBookItemWidget> {
  final List<String> dropdownValues = [
    "To-read",
    "Reading",
    "Read",
  ];
  String currentValue = "";

  @override
  void initState() {
    super.initState();
    currentValue = dropdownValues[0];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: AppDimensions.defaultBorderRadius,
          color: AppColors.secondaryColor,
          boxShadow: [
            AppStyles.primaryShadow,
          ]),
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: widget.book.image,
          width: 52,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                widget.book.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.searchBookNameText,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.book.author.toString(),
                    style: AppStyles.libraryBookItemAuthorText,
                  ),
                  DropdownButton(
                    value: currentValue,
                    items: List.generate(
                      dropdownValues.length,
                      (index) => DropdownMenuItem<String>(
                        value: dropdownValues[index],
                        child: Text(dropdownValues[index]),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          currentValue = value;
                        });
                      }
                    },
                    style: AppStyles.libraryBookItemDropdownText,
                    icon: SvgPicture.asset(AppAssets.icChevronDown),
                    underline: Container(),
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
