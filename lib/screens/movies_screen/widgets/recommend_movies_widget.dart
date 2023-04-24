import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/movies_screen/widgets/movie_item_widget.dart';
import 'package:bookvies/screens/recommend_movies_screen/recommend_movies_screen.dart';
import 'package:flutter/material.dart';

class RecommendMoviesWidget extends StatelessWidget {
  const RecommendMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = Movie.movieList;
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: "Recommend for you",
            onPressed: () => _navigateToRecommendMoviesScreen(context),
            padding: const EdgeInsets.only(left: AppDimensions.defaultPadding)),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(movies.length,
                (index) => MovieItemWidget(movie: movies[index])),
          ),
        )
      ],
    );
  }

  _navigateToRecommendMoviesScreen(BuildContext context) {
    Navigator.pushNamed(context, RecommendMoviesScreen.id);
  }
}
