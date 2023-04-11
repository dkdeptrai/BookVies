import 'package:bookvies/screens/search_books_screen/search_books_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //   case (SignUpScreen.id):
      //     return MaterialPageRoute(builder: (_) => const SignUpScreen());
      //   case (LoginScreen.id):
      //     return MaterialPageRoute(builder: (_) => const LoginScreen());
      case (SearchBooksScreen.id):
        return MaterialPageRoute(builder: (_) => const SearchBooksScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${routeSettings.name}'),
                  ),
                ));
    }
  }
}
