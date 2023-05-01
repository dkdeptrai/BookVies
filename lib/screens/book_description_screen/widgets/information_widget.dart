import 'package:bookvies/common_widgets/expandable_text.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationWidget extends StatelessWidget {
  final Book book;
  const InformationWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        ExpandableText(
          text: book.description,
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
                            const Text(
                              "Author: ",
                              style: AppStyles.descriptionItemText,
                            ),
                            Flexible(
                              child: Text(
                                book.author ?? "Unknown",
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
                          const Text(
                            "Pages: ",
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              book.pages.toString(),
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
                          const Text(
                            "Publisher: ",
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              book.publisher ?? "Unknown",
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
                          const Text(
                            "Publication date: ",
                            style: AppStyles.descriptionItemText,
                          ),
                          Flexible(
                            child: Text(
                              book.firstPublishDate == null
                                  ? "Unknown"
                                  : DateFormat('dd/MM/yyyy').format(
                                      book.firstPublishDate ?? DateTime.now()),
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
                    book.genres.join(", ").toString(),
                    style: AppStyles.primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
