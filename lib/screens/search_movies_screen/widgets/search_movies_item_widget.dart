import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchMovieItemWidget extends StatelessWidget {
  final Movie movie;
  const SearchMovieItemWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        GlobalMethods().navigateToDescriptionScreen(
            context: context,
            mediaId: movie.id,
            mediaType: MediaType.movie.name);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: AppDimensions.defaultBorderRadius,
                child: Image.network(movie.image,
                    height: (size.width / 2 - 20) * 230 / 165,
                    width: size.width / 2 - 30,
                    fit: BoxFit.cover),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFF609DE3)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: [
                    Text(movie.averageRating.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(width: 3),
                    SvgPicture.asset(AppAssets.icRatingStarGradient, height: 12)
                  ]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
