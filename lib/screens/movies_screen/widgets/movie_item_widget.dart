import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;
  const MovieItemWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: AppDimensions.defaultBorderRadius,
                child: Image.network(movie.image,
                    height: size.height * 0.2,
                    width: size.width * 0.28,
                    fit: BoxFit.cover),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(width: 1, color: const Color(0xFF609DE3)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(children: [
                    Text(movie.averageRating.toString(),
                        style: TextStyle(
                            fontSize: 8, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 3),
                    SvgPicture.asset(AppAssets.icRatingStarGradient)
                  ]),
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(movie.name, style: AppStyles.movieItemName)
        ],
      ),
    );
  }
}
