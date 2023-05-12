import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/library_screen/widgets/library_book_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookToReadTab extends StatefulWidget {
  final String type;
  const BookToReadTab({super.key, required this.type});

  @override
  State<BookToReadTab> createState() => _BookToReadTabState();
}

class _BookToReadTabState extends State<BookToReadTab> {
  late final Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = usersRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection("library")
        .where("status", isEqualTo: widget.type)
        .orderBy("addedAt", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitFadingCircle(color: AppColors.mediumBlue);
          }

          final docs = snapshot.data!.docs;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: docs.length,
              itemBuilder: (_, index) {
                final map = docs[index].data() as Map<String, dynamic>;
                final libraryId = docs[index].id;
                final bookId = map["mediaId"];
                final bookName = map["name"];
                final bookImage = map["image"];
                final bookAuthor = map["author"];
                return LibraryBookItemWidget(
                  libraryBookId: libraryId,
                  bookId: bookId,
                  bookName: bookName,
                  bookImage: bookImage,
                  bookAuthor: bookAuthor,
                  readStatus: widget.type,
                );
              });
        });
  }
}
