import 'package:bookvies/common_widgets/section_header.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/movies_screen/widgets/movie_item_widget.dart';
import 'package:bookvies/screens/recommend_movies_screen/recommend_movies_screen.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:flutter/material.dart';

class RecommendMoviesWidget extends StatefulWidget {
  const RecommendMoviesWidget({super.key});

  @override
  State<RecommendMoviesWidget> createState() => _RecommendMoviesWidgetState();
}

class _RecommendMoviesWidgetState extends State<RecommendMoviesWidget> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _getRecommendMovies();
  }

  @override
  Widget build(BuildContext context) {
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

  _getRecommendMovies() async {
    final result =
        await MovieService().getRecommendMovies(context: context, limit: 20);

    setState(() {
      movies.addAll(result['movies']);
    });
  }
}
