import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteItemWidget extends StatelessWidget {
  final String mediaId;
  final String mediaType;
  final String name;
  final String image;
  final String creator;
  const FavoriteItemWidget({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.name,
    required this.image,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        GlobalMethods().navigateToDescriptionScreen(
            context: context, mediaId: mediaId, mediaType: mediaType);
      },
      child: Container(
        width: size.width - 40,
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        decoration: BoxDecoration(
            borderRadius: AppDimensions.defaultBorderRadius,
            boxShadow: [AppStyles.tertiaryShadow],
            color: AppColors.secondaryColor),
        child: Row(children: [
          CachedNetworkImage(
            imageUrl: image,
            width: size.width * 0.1435,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppStyles.searchBookNameText),
                const SizedBox(height: 5),
                Text(creator,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.libraryBookItemAuthorText),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
