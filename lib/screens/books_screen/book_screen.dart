import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_widget.dart';
import 'package:bookvies/screens/books_screen/widgets/popular_books_widget.dart';
import 'package:bookvies/screens/books_screen/widgets/top_rating_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: CustomAppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: SvgPicture.asset(AppAssets.icSearch))
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TopRatingBookWidget(),
              PopularBookWidget(margin: EdgeInsets.only(top: 5)),
              ExploreBooksWidget()
            ],
          ),
        ),
      ),
    );
  }
}
