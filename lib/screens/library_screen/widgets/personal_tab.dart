import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/library_screen/widgets/reading_challenge_widget.dart';
import 'package:bookvies/screens/library_screen/widgets/watching_challenge_widget.dart';
import 'package:flutter/material.dart';

class LibraryPersonalTab extends StatefulWidget {
  const LibraryPersonalTab({super.key});

  @override
  State<LibraryPersonalTab> createState() => _LibraryPersonalTabState();
}

class _LibraryPersonalTabState extends State<LibraryPersonalTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Your activity",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ReadingChallengeWidget(),
          WatchingChallengeWidget()
        ],
      ),
    );
  }
}
