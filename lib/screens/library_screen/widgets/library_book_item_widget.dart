import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/services/library_service.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LibraryBookItemWidget extends StatefulWidget {
  final String libraryBookId;
  final String bookId;
  final String bookImage;
  final String bookName;
  final String bookAuthor;
  final String readStatus;
  const LibraryBookItemWidget(
      {super.key,
      required this.libraryBookId,
      required this.bookId,
      required this.bookImage,
      required this.bookName,
      required this.bookAuthor,
      required this.readStatus});

  @override
  State<LibraryBookItemWidget> createState() => _LibraryBookItemWidgetState();
}

class _LibraryBookItemWidgetState extends State<LibraryBookItemWidget> {
  final List<String> dropdownValues = [
    libraryBookTypeText[LibraryBookType.toRead.name]!,
    libraryBookTypeText[LibraryBookType.reading.name]!,
    libraryBookTypeText[LibraryBookType.read.name]!,
  ];
  String currentValue = "";

  @override
  void initState() {
    super.initState();
    currentValue = dropdownValues
        .where((element) => element == libraryBookTypeText[widget.readStatus])
        .first;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => GlobalMethods().navigateToDescriptionScreen(
          context: context,
          mediaId: widget.bookId,
          mediaType: MediaType.book.name),
      child: Container(
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
            imageUrl: widget.bookImage,
            width: 52,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  widget.bookName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.searchBookNameText,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.63,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.bookAuthor,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.libraryBookItemAuthorText,
                      ),
                    ),
                    const SizedBox(width: 20),
                    DropdownButton(
                      value: currentValue,
                      alignment: Alignment.centerRight,
                      items: List.generate(
                        dropdownValues.length,
                        (index) => DropdownMenuItem<String>(
                          value: dropdownValues[index],
                          child: Text(dropdownValues[index]),
                        ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          // setState(() {
                          currentValue = value;
                          // });
                          _updateBookStatus(value);
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
      ),
    );
  }

  _updateBookStatus(String value) {
    LibraryService().updateBookStatus(
        context, widget.libraryBookId, convertToCamelCase(value));
  }
}
