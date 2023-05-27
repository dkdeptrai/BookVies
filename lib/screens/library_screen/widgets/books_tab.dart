import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/library_screen/widgets/book_to_read_tab.dart';
import 'package:bookvies/screens/library_screen/widgets/currently_added_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:bookvies/common_widgets/search_bar.dart';

class BookTab extends StatefulWidget {
  const BookTab({super.key});

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> with SingleTickerProviderStateMixin {
  late TabController readTabController;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    readTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        CustomSearchBar(
          hint: "Book title, author,...",
          onSearch: () {},
          noBackButton: true,
          margin: const EdgeInsets.only(
              left: AppDimensions.defaultPadding, top: 25),
        ),

        // Currently added book
        const CurrentlyAddedBookWidget(),

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
            children: [
              BookToReadTab(type: LibraryBookType.toRead.name),
              BookToReadTab(type: LibraryBookType.reading.name),
              BookToReadTab(type: LibraryBookType.read.name),
            ],
          ),
        )
      ]),
    );
  }
}
