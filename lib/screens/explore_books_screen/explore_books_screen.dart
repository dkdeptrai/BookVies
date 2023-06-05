import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_item_widget.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreBooksScreen extends StatefulWidget {
  const ExploreBooksScreen({super.key});

  static const id = "/explore-books-screen";

  @override
  State<ExploreBooksScreen> createState() => _ExploreBooksScreenState();
}

class _ExploreBooksScreenState extends State<ExploreBooksScreen> {
  List<Book> books = [];
  DocumentSnapshot? lastDocument;

  @override
  void initState() {
    super.initState();
    getExploreBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Explore Books",
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppAssets.icArrowLeft)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      right: 20, bottom: 20, top: 15, left: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.74),
                  shrinkWrap: true,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return ExploreBookItemWidget(book: books[index]);
                  }),
              TextButton(
                  onPressed: getExploreBooks, child: const Text("Load more"))
            ],
          ),
        ));
  }

  Future<void> getExploreBooks() async {
    try {
      final result = await BookService().getRecommendBooks(
          context: context, limit: 20, lastDocument: lastDocument);
      setState(() {
        books.addAll(result['books']);
        lastDocument = result['lastDocument'];
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
