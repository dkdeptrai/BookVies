import 'package:bookvies/screens/forgot_password_screen/widgets/change_password_notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bookvies/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Verify Forgot password", () {
    testWidgets("Verify with existing email", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text("Forgot password?"));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), "abcxyz@gmail.com");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.byType(ChangePasswordNotificationDialog), findsOneWidget);
      expect(find.text("Please check your inbox!"), findsOneWidget);
    });
    testWidgets("Verify with wrong formatted email", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text("Forgot password?"));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), "abcxyz");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("Invalid email"), findsOneWidget);
    });
    testWidgets("Verify with not existing email", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text("Forgot password?"));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), "notexistemail@gmail.com");
      await tester.tap(find.byType(ElevatedButton).at(0));
      await tester.pumpAndSettle(
        const Duration(seconds: 1),
      );
      expect(find.text("There is no user with this email"), findsOneWidget);
    });
  });
}
