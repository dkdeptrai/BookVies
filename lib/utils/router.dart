import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/book_description_screen/description_screen.dart';
import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/screens/chat_screen/chat_screen.dart';
import 'package:bookvies/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:bookvies/screens/favorite_genres_screen/favorite_genres_screen.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:bookvies/screens/profile_screen/profile_screen.dart';
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
      case (FavoriteGenresScreen.id):
        return MaterialPageRoute(builder: (_) => const FavoriteGenresScreen());
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
      case (ChatScreen.id):
        final args = routeSettings.arguments as Chat;
        return MaterialPageRoute(builder: (_) => ChatScreen(chat: args));
      case (EditProfileScreen.id):
        final args = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  user: args,
                ));
      case (ProfileScreen.id):
        final args = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  userId: args.id,
                ));
      case (DescriptionScreen.id):
        final args = routeSettings.arguments as DescriptionScreenArguments;
        return MaterialPageRoute(
            builder: (_) => DescriptionScreen(
                mediaId: args.mediaId, mediaType: args.mediaType));
      case (WriteReviewScreen.id):
        final media = routeSettings.arguments as Media;
        return MaterialPageRoute(
            builder: (_) => WriteReviewScreen(
                  media: media,
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

class DescriptionScreenArguments {
  final String mediaId;
  final String mediaType;
  const DescriptionScreenArguments(
      {required this.mediaId, required this.mediaType});
}
