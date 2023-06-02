import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/extensions/double_extensions.dart';
import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/rating_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DescriptionTitleWidget extends StatelessWidget {
  const DescriptionTitleWidget({
    super.key,
    required this.media,
  });

  final Media media;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 58),
      width: size.width - 40,
      decoration: AppStyles.primaryNoBorderBoxDecoration,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppDimensions.defaultBorderRadius,
            child: CachedNetworkImage(
              imageUrl: media.image,
              width: 108,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    media.name,
                    style: AppStyles.bookNameForDescriptionHeader,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  RatingWidget(
                    rating: media.averageRating.toFixed(1),
                  ),
                  const SizedBox(height: 16),
                  Text("${media.numberReviews} Reviews"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
