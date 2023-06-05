import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/books_screen/widgets/explore_book_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularBookScreen extends StatefulWidget {
  const PopularBookScreen({super.key});

  static const id = "/popular-book-screen";

  @override
  State<PopularBookScreen> createState() => _PopularBookScreenState();
}

class _PopularBookScreenState extends State<PopularBookScreen> {
  List<Book> books = [];
  DocumentSnapshot? lastDocument;

  @override
  void initState() {
    super.initState();
    getPopularBooks();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: getPopularBooks, child: const Text("Load more"))
            ],
          ),
        ));
  }

  Future<void> getPopularBooks() async {
    try {
      late final QuerySnapshot snapshot;
      if (lastDocument == null) {
        snapshot = await booksRef
            .orderBy("averageRating", descending: true)
            .limit(20)
            .get();
      } else {
        snapshot = await booksRef
            .orderBy("averageRating", descending: true)
            .startAfterDocument(lastDocument!)
            .limit(20)
            .get();
      }
      lastDocument = snapshot.docs.last;
      List<Book> newBooks = snapshot.docs
          .map((e) => Book.fromMap(e.data() as Map<String, dynamic>).copyWith(
                id: e.id,
              ))
          .toList();
      setState(() {
        books.addAll(newBooks);
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
