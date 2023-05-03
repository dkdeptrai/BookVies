import 'package:bookvies/screens/book_description_screen/book_description_screen.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:bookvies/screens/recommend_movies_screen/recommend_movies_screen.dart';
import 'package:bookvies/screens/search_movies_screen/search_movies_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/screens/explore_books_screen/explore_books_screen.dart';
import 'package:bookvies/screens/popular_book_screen/popular_book_screen.dart';
import 'package:bookvies/screens/search_books_screen/search_books_screen.dart';
import 'package:bookvies/screens/top_rating_screen/top_rating_screen.dart';
import 'package:bookvies/screens/write_review_screen/write_review_screen.dart';
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
      case (MainScreen.id):
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case (SearchMoviesScreen.id):
        return MaterialPageRoute(builder: (_) => const SearchMoviesScreen());
      case (RecommendMoviesScreen.id):
        return MaterialPageRoute(builder: (_) => const RecommendMoviesScreen());
      case (TopRatingMoviesScreen.id):
        return MaterialPageRoute(builder: (_) => const TopRatingMoviesScreen());
      case (BookDescriptionScreen.id):
        final bookId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BookDescriptionScreen(bookId: bookId));
      case (WriteReviewScreen.id):
        final mediaId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => WriteReviewScreen(
                  mediaId: mediaId,
                ));

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
