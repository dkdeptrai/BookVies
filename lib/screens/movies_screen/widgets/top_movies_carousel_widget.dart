import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/book_description_screen/description_screen.dart';
import 'package:bookvies/utils/router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopMoviesCarouselWidget extends StatefulWidget {
  final List<Movie> movies;
  const TopMoviesCarouselWidget({super.key, required this.movies});

  @override
  State<TopMoviesCarouselWidget> createState() =>
      _TopMoviesCarouselWidgetState();
}

class _TopMoviesCarouselWidgetState extends State<TopMoviesCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int currentPageIndex = 0;

    return Column(
      children: [
        CarouselSlider(
            items: List.generate(
                widget.movies.length,
                (index) => InkWell(
                      onTap: () =>
                          _navigateToDescriptionScreen(widget.movies[index].id),
                      child: ClipRRect(
                          borderRadius: AppDimensions.defaultBorderRadius,
                          child: Image.network(
                            widget.movies[index].image,
                          )),
                    )),
            options: CarouselOptions(
                height: size.height * 0.35,
                aspectRatio: 16 / 9,
                viewportFraction: 0.5,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPageIndex = index;
                  });
                })),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.movies.length,
                (index) => Container(
                    margin: index < widget.movies.length - 1
                        ? const EdgeInsets.only(right: 5)
                        : const EdgeInsets.only(right: 0),
                    height: 8,
                    width: currentPageIndex == index ? 30 : 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: currentPageIndex == index
                            ? AppColors.primaryGradient
                            : null,
                        color: currentPageIndex == index
                            ? Colors.red
                            : AppColors.greyTextColor))))
      ],
    );
  }

  _navigateToDescriptionScreen(String mediaId) {
    Navigator.pushNamed(context, DescriptionScreen.id,
        arguments: DescriptionScreenArguments(
            mediaId: mediaId, mediaType: MediaType.movie.name));
  }
}
