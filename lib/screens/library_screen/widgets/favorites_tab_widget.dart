import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/library_screen/widgets/favorite_item_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FavoritesTabWidget extends StatelessWidget {
  const FavoritesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SearchBar(
            hint: "Search",
            onSearch: () {},
            noBackButton: true,
            margin: const EdgeInsets.only(
                left: AppDimensions.defaultPadding, top: 25)),
        StreamBuilder(
            stream: favoritesRef.snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitFadingCircle(color: AppColors.mediumBlue));
              }

              List<Map<String, dynamic>> favoritesBooks = [];
              List<Map<String, dynamic>> favoritesMovies = [];
              for (DocumentSnapshot doc in snapshot.data!.docs) {
                if ((doc.data() as Map<String, dynamic>)["mediaType"] ==
                    MediaType.book.name) {
                  favoritesBooks.add(doc.data() as Map<String, dynamic>);
                } else if ((doc.data() as Map<String, dynamic>)["mediaType"] ==
                    MediaType.movie.name) {
                  favoritesMovies.add(doc.data() as Map<String, dynamic>);
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: AppDimensions.defaultPadding, top: 10, bottom: 5),
                    child: Text("Favorite books",
                        style: AppStyles.libraryFavoritesSectionHeader),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final book = favoritesBooks[index];

                        return FavoriteItemWidget(
                            mediaId: book['mediaId'],
                            mediaType: book['mediaType'],
                            name: book['name'],
                            image: book['image'],
                            creator: book['author']);
                      },
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 10),
                      itemCount: favoritesBooks.length),
                  const SizedBox(height: 35),

                  //Movies
                  const Padding(
                    padding: EdgeInsets.only(
                        left: AppDimensions.defaultPadding, bottom: 5),
                    child: Text("Favorite movies",
                        style: AppStyles.libraryFavoritesSectionHeader),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final movie = favoritesMovies[index];

                        return FavoriteItemWidget(
                            mediaId: movie['mediaId'],
                            mediaType: movie['mediaType'],
                            name: movie['name'],
                            image: movie['image'],
                            creator: (movie['author'].map((e) => e.toString()))
                                .toList()
                                .join(", ")
                                .toString());
                      },
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 10),
                      itemCount: favoritesMovies.length),
                ],
              );
            }),
      ]),
    );
  }
}
