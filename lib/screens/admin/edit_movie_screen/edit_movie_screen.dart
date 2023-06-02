import 'package:bookvies/blocs/admin_movies_bloc/admin_movies_bloc.dart';
import 'package:bookvies/common_widgets/admin_text_field.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/loading_manager.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditMovieScreen extends StatefulWidget {
  final Movie movie;
  const EditMovieScreen({super.key, required this.movie});

  static const String id = "/edit-movie-screen";

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController actorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController releaseYearController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.movie.name;
    directorController.text = widget.movie.director.join(", ");
    actorController.text = widget.movie.actors.join(", ");
    descriptionController.text = widget.movie.description;
    releaseYearController.text = widget.movie.releaseYear.toString();
    durationController.text = widget.movie.duration.toString();
  }

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
            title: "Edit book",
            leading: IconButton(
              icon: SvgPicture.asset(AppAssets.icArrowLeft),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: LoadingManager(
        isLoading: isLoading,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name"),
              AdminTextField(controller: nameController, hintText: "Name"),
              const SizedBox(height: 5),
              const Text("Description"),
              AdminTextField(
                  maxLines: 5,
                  controller: descriptionController,
                  hintText: "Description"),
              const SizedBox(height: 5),
              const Text("Directors"),
              AdminTextField(
                  controller: directorController, hintText: "Directors"),
              const SizedBox(height: 5),
              const Text("Actors"),
              AdminTextField(controller: actorController, hintText: "Actors"),
              const SizedBox(height: 5),
              const Text("Release year"),
              AdminTextField(
                  controller: releaseYearController,
                  keyboardType: TextInputType.number,
                  hintText: "Release year"),
              const SizedBox(height: 5),
              const Text("Duration"),
              AdminTextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  hintText: "Duration (minutes)"),
              const SizedBox(height: 15),
              CustomButtonWithGradientBackground(
                  height: 52, text: "Update", onPressed: _onUpdateMovie)
            ],
          ),
        )),
      ),
    );
  }

  _onUpdateMovie() {
    final Movie newMovie = widget.movie.copyWith(
        name: nameController.text,
        director: directorController.text.split(", "),
        actors: actorController.text.split(", "),
        description: descriptionController.text,
        releaseYear: int.parse(releaseYearController.text),
        duration: int.parse(durationController.text));

    context
        .read<AdminMoviesBloc>()
        .add(UpdateMovie(movie: newMovie, context: context));
  }
}
