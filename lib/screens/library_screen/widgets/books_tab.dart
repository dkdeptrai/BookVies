import 'package:bookvies/common_widgets/search_bar.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/library_screen/widgets/book_toread_tab.dart';
import 'package:bookvies/screens/search_books_screen/widgets/search_book_item_widget.dart';
import 'package:flutter/material.dart';

class BookTab extends StatefulWidget {
  const BookTab({super.key});

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> with SingleTickerProviderStateMixin {
  final Book book = Book.bookList[0];
  late TabController readTabController;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    readTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(children: [
        SearchBar(
          hint: "Book title, author,...",
          onSearch: () {},
          noBackButton: true,
          margin: const EdgeInsets.only(
              left: AppDimensions.defaultPadding, top: 25),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(boxShadow: [AppStyles.secondaryShadow]),
          child: ClipRRect(
            borderRadius: AppDimensions.defaultBorderRadius,
            child: Image.network(
              book.image,
              height: size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Text(
          book.name,
          style: AppStyles.sectionHeaderText,
        ),
        const SizedBox(height: 16),
        Text(book.author ?? "", style: AppStyles.subHeaderTextStyle),
        const SizedBox(height: 10),
        TabBar(
            controller: readTabController,
            labelColor: AppColors.primaryTextColor,
            indicatorColor: Colors.black,
            onTap: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            tabs: const [
              Tab(text: "To-read"),
              Tab(text: "Reading"),
              Tab(text: "Read"),
            ]),
        SizedBox(
          height: 700,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              BookToReadTab(),
              Placeholder(),
              Placeholder(),
            ],
          ),
        )
      ]),
    );
  }
}
