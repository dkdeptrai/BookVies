import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/library_screen/widgets/library_book_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookToReadTab extends StatelessWidget {
  final String type;
  const BookToReadTab({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("library")
            .where("type", isEqualTo: type)
            .orderBy("addedAt", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitFadingCircle(color: AppColors.mediumBlue);
          }

          List<Widget> widgets = [];

          snapshot.data!.docs.forEach((element) {
            widgets.add(FutureBuilder(
                future: booksRef
                    .doc((element.data() as Map<String, dynamic>)["mediaId"])
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(color: AppColors.mediumBlue);
                  }

                  Book book = Book.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);

                  return LibraryBookItemWidget(book: book);
                }));
          });

          return Column(
            children: widgets,
          );
        });
  }
}
