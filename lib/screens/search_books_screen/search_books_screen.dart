import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBooksScreen extends StatelessWidget {
  const SearchBooksScreen({super.key});

  static const id = "/search-books-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    // iconSize: 50,
                    icon: SvgPicture.asset(AppAssets.icArrowLeft)),
                Expanded(
                    child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search books, authors, ISBN...",
                        hintStyle: AppStyles.searchBoxText,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(color: AppColors.greyTextColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(color: AppColors.greyTextColor),
                        )),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SvgPicture.asset(AppAssets.icSearch),
                )
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: Book.bookList.length,
                itemBuilder: (context, index) {
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
                        imageUrl: Book.bookList[index].image,
                        width: 52,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Book.bookList[index].name,
                            style: AppStyles.searchBookNameText,
                          ),
                          Text(
                            Book.bookList[index].author,
                            style: AppStyles.searchBookAuthorText,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                  "Rating: ${Book.bookList[index].averageRating}",
                                  style: AppStyles.searchBookRatingText),
                              SvgPicture.asset(AppAssets.icRatingStar)
                            ],
                          )
                        ],
                      )
                    ]),
                  );
                })
          ],
        )),
      ),
    );
  }
}
