import 'package:bookvies/common_widgets/expandable_text.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationWidget extends StatelessWidget {
  final Media media;
  const InformationWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    late final String firstLeftSectionTitle;
    late final String firstLeftSectionContent;
    late final String secondLeftSectionTitle;
    late final String secondLeftSectionContent;
    // late final String thirdLeftSectionTitle;
    // late final String thirdLeftSectionContent;
    late final String firstRightSectionTitle;
    late final String firstRightSectionContent;
    late final String secondRightSectionTitle;
    late final String secondRightSectionContent;

    if (media is Book) {
      firstLeftSectionTitle = "Author: ";
      firstLeftSectionContent = (media as Book).author;
      secondLeftSectionTitle = "Number Of Pages: ";
      secondLeftSectionContent = (media as Book).pages.toString();
      // thirdLeftSectionTitle = "Genres: ";
      // thirdLeftSectionContent = (media as Book).genres.join(", ").toString();
      firstRightSectionTitle = "Publisher: ";
      firstRightSectionContent = (media as Book).publisher ?? "Unknown";
      secondRightSectionTitle = "Publication Date: ";
      secondRightSectionContent = (media as Book).firstPublishDate != null
          ? dateInSlashSplittingFormat((media as Book).firstPublishDate!)
          : "Unknown";
    } else {
      firstLeftSectionTitle = "Director: ";
      firstLeftSectionContent = (media as Movie).director.join(", ").toString();
      secondLeftSectionTitle = "Duration: ";
      secondLeftSectionContent = durationFromMinutes((media as Movie).duration);
      // thirdLeftSectionTitle = "Genres: ";
      // thirdLeftSectionContent = (media as Movie).genres.join(", ").toString();
      firstRightSectionTitle = "Actors: ";
      firstRightSectionContent = (media as Movie).actors.join(", ");
      secondRightSectionTitle = "Release Year: ";
      secondRightSectionContent = (media as Movie).releaseYear.toString();
    }

    return Column(
      children: [
        ExpandableText(
          text: media.description,
          maxLines: 5,
          style: AppStyles.primaryTextStyle,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: (size.width - 40) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              firstLeftSectionTitle,
                              style: AppStyles.descriptionItemText,
                            ),
                            Flexible(
                              child: Text(
                                firstLeftSectionContent,
                                style: AppStyles.primaryTextStyle,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            secondLeftSectionTitle,
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              secondLeftSectionContent,
                              style: AppStyles.primaryTextStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: (size.width - 40) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firstRightSectionTitle,
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              firstRightSectionContent,
                              style: AppStyles.primaryTextStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            secondRightSectionTitle,
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              secondRightSectionContent,
                              style: AppStyles.primaryTextStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Genres: ", style: AppStyles.descriptionItemText),
                Flexible(
                  child: Text(
                    media.genres.join(", ").toString(),
                    style: AppStyles.primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            if (media is Movie)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Rating: ", style: AppStyles.descriptionItemText),
                  Flexible(
                    child: Text(
                      (media as Movie).rating,
                      style: AppStyles.primaryTextStyle,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
