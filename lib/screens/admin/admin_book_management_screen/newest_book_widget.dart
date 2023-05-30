import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/utils/global_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminNewestBookWidget extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const AdminNewestBookWidget(
      {super.key,
      required this.book,
      required this.onEdit,
      required this.onDelete});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => GlobalMethods().navigateToDescriptionScreen(
          context: context, mediaId: book.id, mediaType: MediaType.book.name),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: book.image,
                errorWidget: (_, url, error) => const Icon(Icons.error),
                width: size.width * 0.18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                book.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.adminHeader,
              ),
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: const Color(0XFF609DE3).withOpacity(0.4),
              child: IconButton(
                iconSize: 30,
                icon: SvgPicture.asset(AppAssets.icEdit),
                onPressed: onEdit,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 15,
              backgroundColor: const Color(0XFFF81E1E).withOpacity(0.4),
              child: IconButton(
                iconSize: 30,
                icon: SvgPicture.asset(AppAssets.icTrash),
                onPressed: onDelete,
              ),
            )
          ],
        ),
      ),
    );
  }
}
