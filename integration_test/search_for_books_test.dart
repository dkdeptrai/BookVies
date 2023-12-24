import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bookvies/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Search for books with keyword", () {
    testWidgets("Search for books with keyword 'akira'", (tester) async {
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
      final Finder searchIcon = find.byKey(const Key("bookScreenSearchIcon"));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, "akira");
      await tester.tap(find.byKey(const Key("searchBarSearchButton")).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Akira, Vol. 1"), findsOneWidget);
      expect(find.text("Akira, Vol. 2"), findsOneWidget);
      expect(find.text("Akira, Vol. 3"), findsOneWidget);
      expect(find.text("Akira, Vol. 4"), findsOneWidget);
      expect(find.text("Akira, Vol. 5"), findsOneWidget);
      expect(find.text("Akira, Vol. 6"), findsOneWidget);

      FirebaseAuth.instance.signOut();
    });

    testWidgets("Search for books with keyword 'Akira'", (tester) async {
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
      final Finder searchIcon = find.byKey(const Key("bookScreenSearchIcon"));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, "Akira");
      await tester.tap(find.byKey(const Key("searchBarSearchButton")).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Akira, Vol. 1"), findsOneWidget);
      expect(find.text("Akira, Vol. 2"), findsOneWidget);
      expect(find.text("Akira, Vol. 3"), findsOneWidget);
      expect(find.text("Akira, Vol. 4"), findsOneWidget);
      expect(find.text("Akira, Vol. 5"), findsOneWidget);
      expect(find.text("Akira, Vol. 6"), findsOneWidget);

      FirebaseAuth.instance.signOut();
    });
    testWidgets("Search for books with keyword 'Kira-Kira'", (tester) async {
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
      final Finder searchIcon = find.byKey(const Key("bookScreenSearchIcon"));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, "Kira-Kira");
      await tester.tap(find.byKey(const Key("searchBarSearchButton")).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Kira-Kira"), findsOneWidget);

      FirebaseAuth.instance.signOut();
    });

    testWidgets("Search for books with keyword 'Akira, Vol. 1'",
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
      final Finder searchIcon = find.byKey(const Key("bookScreenSearchIcon"));
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, "Akira, Vol. 1");
      await tester.tap(find.byKey(const Key("searchBarSearchButton")).first);
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      final Finder searchBookItemWidget =
          find.byKey(ValueKey('SearchBookItemWidget'));
      final Finder bookName = find.descendant(
        of: searchBookItemWidget,
        matching: find.text("Akira, Vol. 1"),
      );

      expect(bookName, findsOneWidget);

      FirebaseAuth.instance.signOut();
    });
  });
}
