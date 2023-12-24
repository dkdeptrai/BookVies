import 'package:bookvies/screens/books_screen/widgets/highest_rating_book_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bookvies/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Upvote and Downvote", () {
    testWidgets("Upvoting increases up votes count", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedUpVoteIconFinder =
          find.bySemanticsLabel("Outlined Up vote Icon").first;
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder upVoteCountFinder =
          find.byKey(const Key("upVoteCount")).first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledUpVoteIconFinder =
          find.bySemanticsLabel("Filled Up vote Icon").first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;

      await tester.tap(outlinedUpVoteIconFinder);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      final String newUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;
      expect(int.parse(newUpvoteCount), int.parse(oldUpvoteCount) + 1);

      // return to original state
      await tester.tap(filledUpVoteIconFinder);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      await FirebaseAuth.instance.signOut();
    });

    testWidgets("Downvoting increases down votes count", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldDownvoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;

      await tester.tap(outlinedDownVoteIconFinder);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      final String newDownvoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;
      expect(int.parse(newDownvoteCount), int.parse(oldDownvoteCount) + 1);

      // return to original state
      await tester.tap(filledDownVoteIconFinder);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      await FirebaseAuth.instance.signOut();
    });

    testWidgets("Upvoting then Downvoting increases down votes count",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedUpVoteIconFinder =
          find.bySemanticsLabel("Outlined Up vote Icon").first;
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder upVoteCountFinder =
          find.byKey(const Key("upVoteCount")).first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledUpVoteIconFinder =
          find.bySemanticsLabel("Filled Up vote Icon").first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldDownVoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;

      await tester.tap(outlinedUpVoteIconFinder);

      await tester.tap(outlinedDownVoteIconFinder);
      await tester.pumpAndSettle();

      final String newDownVoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;
      expect(int.parse(newDownVoteCount), int.parse(oldDownVoteCount) + 1);

      // return to original state
      await tester.tap(filledDownVoteIconFinder);
      await tester.pumpAndSettle();
      await FirebaseAuth.instance.signOut();
    });
    testWidgets("Downvoting then Upvoting increases up votes count",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedUpVoteIconFinder =
          find.bySemanticsLabel("Outlined Up vote Icon").first;
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder upVoteCountFinder =
          find.byKey(const Key("upVoteCount")).first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledUpVoteIconFinder =
          find.bySemanticsLabel("Filled Up vote Icon").first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;

      await tester.tap(outlinedDownVoteIconFinder);
      await tester.pumpAndSettle();

      await tester.tap(outlinedUpVoteIconFinder);
      await tester.pumpAndSettle();

      final String newUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;
      expect(int.parse(newUpvoteCount), int.parse(oldUpvoteCount) + 1);

      // return to original state
      await tester.tap(filledUpVoteIconFinder);
      await tester.pumpAndSettle();
      await FirebaseAuth.instance.signOut();
    });

    testWidgets("Upvoting then Upvoting delete the vote", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedUpVoteIconFinder =
          find.bySemanticsLabel("Outlined Up vote Icon").first;
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder upVoteCountFinder =
          find.byKey(const Key("upVoteCount")).first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledUpVoteIconFinder =
          find.bySemanticsLabel("Filled Up vote Icon").first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;

      await tester.tap(outlinedUpVoteIconFinder);
      await tester.pumpAndSettle();

      await tester.tap(filledUpVoteIconFinder);
      await tester.pumpAndSettle();

      final String newUpvoteCount =
          tester.widget<Text>(upVoteCountFinder).data!;
      expect(int.parse(newUpvoteCount), int.parse(oldUpvoteCount));

      FirebaseAuth.instance.signOut();
    });
    testWidgets("Downvoting then Downvoting delete the vote", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // authenticating
      await tester.enterText(
          find.byType(TextFormField).at(0), "clonecuakhoa1@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 2),
      );
      // accessing book description screen
      await tester.tap(find.byType(HighestRatingBookWidget).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );

      // Description Screen widget finders
      final Finder scrollableFinder =
          find.byKey(const Key("descriptionScreenScrollable"));
      final Finder outlinedUpVoteIconFinder =
          find.bySemanticsLabel("Outlined Up vote Icon").first;
      final Finder outlinedDownVoteIconFinder =
          find.bySemanticsLabel("Outlined Down vote Icon").first;
      final Finder upVoteCountFinder =
          find.byKey(const Key("upVoteCount")).first;
      final Finder downVoteCountFinder =
          find.byKey(const Key("downVoteCount")).first;
      final Finder filledUpVoteIconFinder =
          find.bySemanticsLabel("Filled Up vote Icon").first;
      final Finder filledDownVoteIconFinder =
          find.bySemanticsLabel("Filled Down vote Icon").first;

      await tester.drag(scrollableFinder, const Offset(0, -600));

      final String oldDownvoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;

      await tester.tap(outlinedDownVoteIconFinder);
      await tester.pumpAndSettle();

      await tester.tap(filledDownVoteIconFinder);
      await tester.pumpAndSettle();

      final String newDownvoteCount =
          tester.widget<Text>(downVoteCountFinder).data!;
      expect(int.parse(oldDownvoteCount), int.parse(newDownvoteCount));

      FirebaseAuth.instance.signOut();
    });
  });
}
