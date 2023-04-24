import 'package:bookvies/common_widgets/search_bar.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/search_movies_screen/widgets/search_movies_item_widget.dart';
import 'package:flutter/material.dart';

class SearchMoviesScreen extends StatelessWidget {
  const SearchMoviesScreen({super.key});

  static const id = "/search-movies-screen";

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = Movie.movieList;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          const SearchBar(hint: "Search movies, actors,..."),
          GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding,
                  vertical: AppDimensions.defaultPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 165 / 244,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemCount: movies.length,
              itemBuilder: (context, index) =>
                  SearchMovieItemWidget(movie: movies[index]))
        ])),
      ),
    );
  }
}
