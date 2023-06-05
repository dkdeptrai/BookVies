import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/movies_screen/widgets/movie_item_widget.dart';
import 'package:bookvies/screens/top_rating_screen/top_rating_screen.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopRatingMoviesWidget extends StatefulWidget {
  const TopRatingMoviesWidget({super.key});

  @override
  State<TopRatingMoviesWidget> createState() => _TopRatingMoviesWidgetState();
}

class _TopRatingMoviesWidgetState extends State<TopRatingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: "Top rating",
            onPressed: () => _navigateToTopRatingMoviesScreen(context),
            padding: const EdgeInsets.only(left: AppDimensions.defaultPadding)),
        FutureBuilder<List<Movie>>(
            future: _getTopRatingMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.only(left: AppDimensions.defaultPadding),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(
                        snapshot.data!.length,
                        (index) =>
                            MovieItemWidget(movie: snapshot.data![index])),
                  ),
                );
              }

              return Container();
            })
      ],
    );
  }

  _navigateToTopRatingMoviesScreen(BuildContext context) {
    Navigator.pushNamed(context, TopRatingMoviesScreen.id);
  }

  Future<List<Movie>> _getTopRatingMovies() async {
    final result = await MovieService().getTopRatingMovies(limit: 20);

    return result['movies'];
  }
}
