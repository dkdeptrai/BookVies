import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/search_movies_screen/widgets/search_movies_item_widget.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopRatingMoviesScreen extends StatefulWidget {
  const TopRatingMoviesScreen({super.key});

  static const id = "/top-rating-movies-screen";

  @override
  State<TopRatingMoviesScreen> createState() => _TopRatingMoviesScreenState();
}

class _TopRatingMoviesScreenState extends State<TopRatingMoviesScreen> {
  List<Movie> movies = [];
  DocumentSnapshot? lastDocument;

  @override
  void initState() {
    super.initState();
    _getRecommendMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(
            title: "Top Rating Movies",
            leading: IconButton(
              icon: SvgPicture.asset(AppAssets.icArrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                    SearchMovieItemWidget(movie: movies[index])),
            TextButton(
                onPressed: _getRecommendMovies, child: const Text("Load more"))
          ]),
        )));
  }

  Future<List<Movie>> _getRecommendMovies() async {
    final result = await MovieService()
        .getTopRatingMovies(limit: 20, lastDocument: lastDocument);

    lastDocument = result['lastDocument'];
    setState(() {
      movies.addAll(result['movies']);
    });

    return result['movies'];
  }
}
