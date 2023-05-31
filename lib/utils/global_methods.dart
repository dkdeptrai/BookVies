import 'package:bookvies/screens/book_description_screen/description_screen.dart';
import 'package:bookvies/utils/router.dart';
import 'package:flutter/material.dart';

class GlobalMethods {
  void navigateToDescriptionScreen(
      {required BuildContext context,
      required String mediaId,
      required String mediaType}) {
    Navigator.pushNamed(context, DescriptionScreen.id,
        arguments:
            DescriptionScreenArguments(mediaId: mediaId, mediaType: mediaType));
  }

  List<String> generateKeywords(String word) {
    List<String> keywords = [];
    String prevKey = '';
    List<String> charArray = word.toLowerCase().split('');
    for (var char in charArray) {
      prevKey = prevKey + char;
      keywords.add(prevKey);
    }

    return keywords;
  }
}
