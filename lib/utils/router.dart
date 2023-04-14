import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/screens/explore_books_screen/explore_books_screen.dart';
import 'package:bookvies/screens/popular_book_screen/popular_book_screen.dart';
import 'package:bookvies/screens/search_books_screen/search_books_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (SignUpScreen.id):
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case (LoginScreen.id):
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case (SearchBooksScreen.id):
        return MaterialPageRoute(builder: (_) => const SearchBooksScreen());
      case (PopularBookScreen.id):
        return MaterialPageRoute(builder: (_) => const PopularBookScreen());
      case (ExploreBooksScreen.id):
        return MaterialPageRoute(builder: (_) => const ExploreBooksScreen());
      case (ForgotPasswordScreen.id):
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

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
