import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/movies_screen/widgets/recommend_movies_widget.dart';
import 'package:bookvies/screens/movies_screen/widgets/top_movies_widget.dart';
import 'package:bookvies/screens/movies_screen/widgets/top_rating_movies_widget.dart';
import 'package:bookvies/screens/search_movies_screen/search_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: CustomAppBar(
              title: 'Movies',
              actions: [
                IconButton(
                    onPressed: _navigateToSearchScreen,
                    icon: SvgPicture.asset(AppAssets.icSearch))
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.defaultPadding),
            child: Column(children: const [
              TopMoviesWidget(),
              SizedBox(height: 20.0),
              RecommendMoviesWidget(),
              TopRatingMoviesWidget(),
            ]),
          ),
        ));
  }

  _navigateToSearchScreen() {
    Navigator.pushNamed(context, SearchMoviesScreen.id);
  }
}
