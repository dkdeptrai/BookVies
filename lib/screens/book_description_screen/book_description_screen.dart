import 'package:bookvies/common_widgets/shimmer_loading_widget.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/book_description_screen/widgets/description_title_widget.dart';
import 'package:bookvies/screens/book_description_screen/widgets/information_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/book_model.dart';

import '../../constant/assets.dart';

class BookDescriptionScreen extends StatefulWidget {
  final String bookId;
  const BookDescriptionScreen({super.key, required this.bookId});
  // final bookData = booksRef.doc('00RHCU3W5lP3Djq9UCmD');

  static const id = "/book-description-screen";

  @override
  State<BookDescriptionScreen> createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    const rating = 3;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
            child: FutureBuilder<DocumentSnapshot>(
          future: booksRef.doc(widget.bookId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            late final Book book;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                //TODO: display some error
                return const Text('Error: \${snapshot.error}');
              }
              if (snapshot.data?.data() == null) {
                return Text(snapshot.data.toString());
              } else {
                book =
                    Book.fromMap(snapshot.data?.data() as Map<String, dynamic>);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                  child: Column(
                    children: [
                      DescriptionTitleWidget(size: size, book: book),
                      InformationWidget(book: book),
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
              );
              // Build your widget using bookData
            } else {
              return const ShimmerLoadingWidget(); // Show a loading indicator while data is being fetched
            }
          },
        )));
  }
}
