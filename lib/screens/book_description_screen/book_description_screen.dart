import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/rating_widget.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/assets.dart';

class BookDescriptionScreen extends StatefulWidget {
  const BookDescriptionScreen({super.key});

  @override
  State<BookDescriptionScreen> createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final book = Book.bookList[0];
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: "",
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
              },
              icon: SvgPicture.asset(AppAssets.icArrowLeft)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.icShare),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: size.width - 40,
                decoration: AppStyles.primaryNoBorderBoxDecoration,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: book.image,
                      width: 108,
                      fit: BoxFit.fill,
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              book.name,
                              style: AppStyles.bookNameForDescriptionHeader,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                            ),
                            RatingWidget(rating: book.averageRating),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
