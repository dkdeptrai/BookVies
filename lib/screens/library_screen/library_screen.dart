import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/library_screen/widgets/books_tab.dart';
import 'package:bookvies/screens/library_screen/widgets/favorites_tab_widget.dart';
import 'package:bookvies/screens/library_screen/widgets/reviewed_tab.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Library", style: AppStyles.actionBarText),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: "Books"),
                Tab(text: "Reviewed"),
                Tab(text: "Favorites"),
                Tab(text: "Personal"),
              ],
              labelColor: AppColors.primaryTextColor,
              indicatorColor: Colors.black,
              labelPadding: const EdgeInsets.all(0),
              labelStyle: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                BookTab(),
                ReviewedTab(),
                FavoritesTabWidget(),
                Placeholder(),
              ]),
            ),
          ],
        ));
  }
}
