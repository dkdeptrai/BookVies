import 'package:bookvies/main.dart' as app;
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Verify login screen", () {
    testWidgets("Login with correct credentials", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byType(TextFormField).at(0), "abcxyz@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "abc123");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.byType(MainScreen), findsOneWidget);
    });
    testWidgets("Login with wrong password", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byType(TextFormField).at(0), "abcxyz@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "abc321");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Wrong email or password!").at(0), findsOneWidget);
    });
    testWidgets("Login with email not exist", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byType(TextFormField).at(0), "xyzabc@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "abc123");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("User not found!").at(0), findsOneWidget);
    });
    testWidgets("Login with wrong email format", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(0), "abcxyz");
      await tester.enterText(find.byType(TextFormField).at(1), "abc123");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Something went wrong!").at(0), findsOneWidget);
    });
  });
}
