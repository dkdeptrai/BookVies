import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/library_screen/widgets/library_book_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookToReadTab extends StatelessWidget {
  const BookToReadTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("to_read_books")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitFadingCircle();
          }

          List<Book> books = snapshot.data!.docs
              .map((e) => Book.fromMap(e.data() as Map<String, dynamic>))
              .toList();
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (_, index) {
              return LibraryBookItemWidget(book: books[index]);
            },
          );
        });
  }
}
