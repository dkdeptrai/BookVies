import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentlyAddedBookWidget extends StatelessWidget {
  const CurrentlyAddedBookWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: usersRef
            .doc(currentUser!.uid)
            .collection("library")
            .orderBy("addedAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.data!.docs.isNotEmpty) {
            final Map<String, dynamic> map =
                snapshot.data!.docs[0].data() as Map<String, dynamic>;
            final String id = map["mediaId"];
            final String name = map["name"];
            final String image = map["image"];
            final String author = map["author"];
            return Column(
              children: [
                InkWell(
                  onTap: () => GlobalMethods().navigateToDescriptionScreen(
                      context: context,
                      mediaId: id,
                      mediaType: MediaType.book.name),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration:
                        BoxDecoration(boxShadow: [AppStyles.secondaryShadow]),
                    child: ClipRRect(
                      borderRadius: AppDimensions.defaultBorderRadius,
                      child: Image.network(
                        image,
                        height: size.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  name,
                  style: AppStyles.sectionHeaderText,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.defaultPadding),
                  child: Text(author,
                      textAlign: TextAlign.center,
                      style: AppStyles.subHeaderTextStyle),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
