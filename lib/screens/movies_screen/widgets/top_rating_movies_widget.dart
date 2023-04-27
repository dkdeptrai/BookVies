import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/movies_screen/widgets/movie_item_widget.dart';
import 'package:bookvies/screens/top_rating_screen/top_rating_screen.dart';
import 'package:flutter/material.dart';

class TopRatingMoviesWidget extends StatelessWidget {
  const TopRatingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = Movie.movieList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: "Top rating",
            onPressed: () => _navigateToTopRatingMoviesScreen(context),
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

  _navigateToTopRatingMoviesScreen(BuildContext context) {
    Navigator.pushNamed(context, TopRatingMoviesScreen.id);
  }
}
