import 'dart:async';

import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/rating_widget.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';

import '../../constant/assets.dart';

class BookDescriptionScreen extends StatefulWidget {
  BookDescriptionScreen({super.key});
  final bookData = booksRef.doc('00RHCU3W5lP3Djq9UCmD');
  @override
  State<BookDescriptionScreen> createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildFutureBook();
  }

  Widget _buildFutureBook() {
    var rating = 3;
    return FutureBuilder<DocumentSnapshot>(
      future: widget.bookData.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        late final Book book;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // display some error
            return const Text('Error: \${snapshot.error}');
          }
          if (snapshot.data?.data() == null) {
            return Text(snapshot.data.toString());
          } else {
            book = Book.fromMap(snapshot.data?.data() as Map<String, dynamic>);
          }

          final Size size = MediaQuery.of(context).size;
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(
                title: "",
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.id, (route) => false);
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
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 58),
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
                                    style:
                                        AppStyles.bookNameForDescriptionHeader,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 2,
                                  ),
                                  Center(
                                    child: RatingWidget(
                                      rating: book.averageRating,
                                    ),
                                  ),
                                  // Text("${book.reviewsNum} Reviews"),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      book.description,
                      style: AppStyles.primaryTextStyle,
                      textAlign: TextAlign.justify,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15, top: 15),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: (size.width - 40) / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Author: ",
                                              style:
                                                  AppStyles.descriptionItemText,
                                            ),
                                            Flexible(
                                              child: Text(
                                                book.author ?? "Unknown",
                                                style:
                                                    AppStyles.primaryTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Pages: ",
                                            style:
                                                AppStyles.descriptionItemText,
                                          ),
                                          Flexible(
                                            child: Text(
                                              book.pages.toString(),
                                              style: AppStyles.primaryTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: (size.width - 40) / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Publisher: ",
                                              style:
                                                  AppStyles.descriptionItemText,
                                            ),
                                            Flexible(
                                              child: Text(
                                                book.publisher ?? "Unknown",
                                                style:
                                                    AppStyles.primaryTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Publication date: ",
                                            style:
                                                AppStyles.descriptionItemText,
                                          ),
                                          Flexible(
                                            child: Text(
                                              book.firstPublishDate == null
                                                  ? "Unknown"
                                                  : DateFormat('dd/MM/yyyy')
                                                      .format(
                                                          book.firstPublishDate ??
                                                              DateTime.now()),
                                              style: AppStyles.primaryTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Genres: ",
                                  style: AppStyles.descriptionItemText),
                              Flexible(
                                child: Text(
                                  book.genres.join(", ").toString(),
                                  style: AppStyles.primaryTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 4,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomButtonWithGradientBackground(
                      margin: const EdgeInsets.only(top: 34),
                      height: 53,
                      width: 200,
                      text: "Add to library",
                      onPressed: () {},
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: LinearProgressIndicator(
                              value: index + 1 <= rating ? 1 : 0,
                              minHeight: 10,
                              backgroundColor: AppColors.greyTextColor,
                              color: Colors.amber,
                            ),
                          );
                        },
                      ),
                    ),
                    CustomButtonWithGradientBackground(
                      margin: const EdgeInsets.only(top: 34),
                      height: 53,
                      width: 233,
                      text: "Write your review",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )),
          );
          // Build your widget using bookData
        } else {
          return const ShimmerLoadingWidget(); // Show a loading indicator while data is being fetched
        }
      },
    );
  }
}
