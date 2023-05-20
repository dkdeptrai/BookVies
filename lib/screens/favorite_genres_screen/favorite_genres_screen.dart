import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteGenresScreen extends StatefulWidget {
  static const String id = '/favorite-genres-screen';
  const FavoriteGenresScreen({super.key});

  @override
  State<FavoriteGenresScreen> createState() => _FavoriteGenresScreenState();
}

class _FavoriteGenresScreenState extends State<FavoriteGenresScreen> {
  List<String> genres = [
    'Romance',
    'Fiction',
    'Young Adult',
    'Fantasy',
    'Science Fiction',
    'Nonfiction',
    'Children',
    'History',
    'Mystery',
    'Covers',
    'Horror',
    'Historical Fiction',
    'Best',
    'Gay',
    'Titles',
    'Paranormal',
    'Love',
    'Middle Grade',
    'Contemporary',
    'Historical Romance',
    'Thriller',
    'Biography',
    'LGBT',
    'Queer',
    'Women',
    'Series',
    'Classics',
    'Graphic Novels',
    'Memoir',
    'Adult',
    'Philosophy',
    'Novels',
    'Roman',
    'Utopia',
    'Sociology',
    'Audiobook',
    'Crime',
    'Birds',
    'Adventure',
    'Medieval',
    'Dystopia',
    'Mythology',
    'Comedy',
    'Japan',
    'Humor',
  ];
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    genres.sort();
    isSelected = List<bool>.generate(genres.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Select your favorite genres',
          leading: TextButton(
            child: const Text('Skip'),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventInitialize());
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                // Replace ToggleButtons with Wrap
                spacing: 8.0, // Space between buttons horizontally
                runSpacing: 8.0, // Space between buttons vertically
                children: List<Widget>.generate(genres.length, (int index) {
                  return ChoiceChip(
                    labelStyle: AppStyles.primaryTextStyle,
                    padding: const EdgeInsets.all(12),
                    selectedColor: AppColors.mediumBlue,
                    label: Text(genres[index]),
                    selected: isSelected[index],
                    onSelected: (bool selected) {
                      setState(() {
                        isSelected[index] = selected;
                      });
                    },
                  );
                }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: CustomButtonWithGradientBackground(
                  height: 52,
                  text: 'Submit',
                  onPressed: () => _updateFavoriteGenres(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateFavoriteGenres() async {
    List<String> userFavoriteGenres = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        userFavoriteGenres.add(genres[i]);
      }
    }
    context
        .read<AuthBloc>()
        .add(AuthEventAddUserFavoriteGenres(userFavoriteGenres));
  }
}
