import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/movies_screen/widgets/top_movies_carousel_widget.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopMoviesWidget extends StatefulWidget {
  const TopMoviesWidget({super.key});

  @override
  State<TopMoviesWidget> createState() => _TopMoviesWidgetState();
}

class _TopMoviesWidgetState extends State<TopMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: getTopMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.mediumBlue,
                size: 50.0,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          final movies = snapshot.data!;
          return TopMoviesCarouselWidget(movies: movies);
        });
  }

  Future<List<Movie>> getTopMovies() async {
    final result = await MovieService().getTopRatingMovies(limit: 5);

    return result['movies'];
  }
}
