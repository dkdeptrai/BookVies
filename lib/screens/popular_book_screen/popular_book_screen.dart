import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularBookScreen extends StatelessWidget {
  const PopularBookScreen({super.key});

  static const id = "/popular-book-screen";

  @override
  Widget build(BuildContext context) {
    List<Book> books = [];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(
            title: "Popular Books",
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppAssets.icArrowLeft)),
          ),
        ),
        body: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding:
                const EdgeInsets.only(right: 20, bottom: 20, top: 15, left: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.74),
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ExploreBookItemWidget(book: books[index]);
            }));
  }
}
