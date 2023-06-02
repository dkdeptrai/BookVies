import 'dart:io';

import 'package:bookvies/blocs/admin_movies_bloc/admin_movies_bloc.dart';
import 'package:bookvies/common_widgets/admin_text_field.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/loading_manager.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/services/storage_service.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddMovieScreen extends StatefulWidget {
  const AdminAddMovieScreen({super.key});

  static const String id = "/admin-add-movie-screen";

  @override
  State<AdminAddMovieScreen> createState() => _AdminAddMovieScreenState();
}

class _AdminAddMovieScreenState extends State<AdminAddMovieScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController actorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController releaseYearController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  List<String> genres = [];
  String rating = "";
  String? imagePath;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    directorController.dispose();
    actorController.dispose();
    descriptionController.dispose();
    releaseYearController.dispose();
    durationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(
              title: "Add movie",
              leading: IconButton(
                icon: SvgPicture.asset(AppAssets.icArrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))),
      body: SafeArea(
        child: LoadingManager(
          isLoading: isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name", style: AppStyles.adminHeader),
                  AdminTextField(controller: nameController, hintText: "Name"),
                  const SizedBox(height: 5),
                  const Text("Description", style: AppStyles.adminHeader),
                  AdminTextField(
                      maxLines: 5,
                      controller: descriptionController,
                      hintText: "Description"),
                  const SizedBox(height: 5),
                  const Text("Image", style: AppStyles.adminHeader),
                  const SizedBox(height: 5),
                  imagePath == null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(40),
                              elevation: 0,
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () async {
                            final String? path =
                                await pickImage(source: ImageSource.gallery);
                            if (path != null) {
                              setState(() {
                                imagePath = path;
                              });
                            }
                          },
                          child: SvgPicture.asset(AppAssets.icPicture))
                      : Image.file(File(imagePath!)),
                  const SizedBox(height: 5),
                  const Text("Directors", style: AppStyles.adminHeader),
                  AdminTextField(
                      controller: directorController, hintText: "Directors"),
                  const SizedBox(height: 5),
                  const Text("Actors", style: AppStyles.adminHeader),
                  AdminTextField(
                      controller: actorController, hintText: "Actors"),
                  const SizedBox(height: 5),
                  const Text("Release year", style: AppStyles.adminHeader),
                  AdminTextField(
                      controller: releaseYearController,
                      keyboardType: TextInputType.number,
                      hintText: "Release year"),
                  const SizedBox(height: 5),
                  const Text("Duration", style: AppStyles.adminHeader),
                  AdminTextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      hintText: "Duration (minutes)"),
                  const SizedBox(height: 5),
                  const Text("Genres", style: AppStyles.adminHeader),
                  Wrap(
                    children:
                        List.generate(AppConstants.movieGenres.length, (index) {
                      final String genre = AppConstants.movieGenres[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ChoiceChip(
                          labelStyle: const TextStyle(
                              color: AppColors.primaryTextColor),
                          label: Text(genre),
                          selectedColor: AppColors.lightBlueBackground,
                          selected: genres.contains(genre),
                          onSelected: (isSelected) {
                            if (isSelected) {
                              setState(() {
                                genres.add(genre);
                              });
                            } else {
                              setState(() {
                                genres.remove(genre);
                              });
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  const Text("Rating", style: AppStyles.adminHeader),
                  Wrap(
                    children: List.generate(AppConstants.MPAMovieRating.length,
                        (index) {
                      final String rating = AppConstants.MPAMovieRating[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ChoiceChip(
                          labelStyle: const TextStyle(
                              color: AppColors.primaryTextColor),
                          label: Text(rating),
                          selectedColor: AppColors.lightBlueBackground,
                          selected: rating == this.rating,
                          onSelected: (isSelected) {
                            if (isSelected) {
                              setState(() {
                                this.rating = rating;
                              });
                            } else {
                              setState(() {
                                this.rating = "";
                              });
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),
                  CustomButtonWithGradientBackground(
                      height: 52, text: "Add", onPressed: _onAddMovie),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onAddMovie() async {
    _setLoading();
    if (imagePath != null) {
      final imageUrl = await StorageService()
          .uploadFileToStorage(path: imagePath!, name: nameController.text);

      if (imageUrl != null) {
        final docRef = moviesRef.doc();
        final movie = Movie(
            id: docRef.id,
            name: nameController.text,
            description: descriptionController.text,
            image: imageUrl,
            reviews: [],
            numberReviews: 0,
            averageRating: 0,
            genres: genres,
            director: directorController.text.split(", "),
            rating: rating,
            duration: int.parse(durationController.text),
            releaseYear: int.parse(releaseYearController.text),
            actors: actorController.text.split(", "));
        await docRef.set(movie.toMap());

        if (!mounted) return;
        context
            .read<AdminMoviesBloc>()
            .add(InsertMovie(movie: movie, context: context));
      }
    }
    _setLoading();
  }

  _setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
