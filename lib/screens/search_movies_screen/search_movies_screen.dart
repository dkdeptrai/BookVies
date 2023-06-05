import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/search_movies_screen/widgets/search_movies_item_widget.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:bookvies/common_widgets/search_bar.dart' show CustomSearchBar;

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({super.key});

  static const id = "/search-movies-screen";

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  List<Movie> movies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          CustomSearchBar(
              controller: _searchController,
              hint: "Search movies, actors,...",
              onSearch: _onSearchMovies),
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

  _onSearchMovies() async {
    final result = await MovieService()
        .searchMovies(keyword: _searchController.text, limit: 20);

    setState(() {
      movies.addAll(result);
    });
  }
}
