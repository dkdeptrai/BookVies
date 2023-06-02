import 'package:bookvies/blocs/admin_movies_bloc/admin_movies_bloc.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/gradient_text.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/admin/admin_add_movie_screen/admin_add_movie_screen.dart';
import 'package:bookvies/screens/admin/admin_book_management_screen/admin_media_widget.dart';
import 'package:bookvies/screens/admin/admin_search_movie_screen.dart';
import 'package:bookvies/screens/admin/edit_movie_screen/edit_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminMoviesScreen extends StatefulWidget {
  const AdminMoviesScreen({super.key});

  @override
  State<AdminMoviesScreen> createState() => _AdminMoviesScreenState();
}

class _AdminMoviesScreenState extends State<AdminMoviesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminMoviesBloc>().add(LoadAdminMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(title: "Movie management")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 20, bottom: 30),
                      decoration: BoxDecoration(
                          color: AppColors.lightBlueBackground,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Number of movies",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkBlueBackground),
                            ),
                            const SizedBox(height: 10),
                            const GradientText(
                                text: "20000",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w600),
                                gradient: AppColors.primaryGradient),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: AppColors.lightGrey,
                        child: IconButton(
                            onPressed: () => _navigateToAddMovieScreen(context),
                            icon: SvgPicture.asset(AppAssets.icPlus)),
                      ),
                      const SizedBox(height: 10),
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: AppColors.lightGrey,
                        child: IconButton(
                            onPressed: () => _navigateToSearchScreen(context),
                            icon: SvgPicture.asset(AppAssets.icSearch)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            BlocBuilder<AdminMoviesBloc, AdminMoviesState>(
              builder: (context, state) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.defaultPadding),
                    itemBuilder: (_, index) {
                      final Movie movie = state.movies[index];
                      return AdminMediaWidget(
                          media: movie,
                          mediaType: MediaType.movie.name,
                          onEdit: () =>
                              _navigateToEditMovieScreen(movie: movie),
                          onDelete: () => _deleteMovie(movieId: movie.id));
                    },
                    separatorBuilder: (_, index) => const SizedBox(height: 15),
                    itemCount: state.movies.length);
              },
            )
          ],
        ),
      ),
    );
  }

  _navigateToAddMovieScreen(BuildContext context) {
    Navigator.pushNamed(context, AdminAddMovieScreen.id);
  }

  _navigateToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, AdminSearchMovieScreen.id);
  }

  _navigateToEditMovieScreen({required Movie movie}) {
    Navigator.pushNamed(context, EditMovieScreen.id, arguments: movie);
  }

  _deleteMovie({required String movieId}) {
    context
        .read<AdminMoviesBloc>()
        .add(DeleteMovie(movieId: movieId, context: context));
  }
}
