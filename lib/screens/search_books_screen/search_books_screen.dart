import 'package:bookvies/common_widgets/search_bar.dart';
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
            const SearchBar(hint: "Search books, authors, ISBN..."),
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
                            Book.bookList[index].author.toString(),
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
