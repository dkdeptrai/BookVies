import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/screens/admin/add_book_screen/admin_add_book_screen.dart';
import 'package:bookvies/screens/admin/admin_add_movie_screen/admin_add_movie_screen.dart';
import 'package:bookvies/screens/admin/admin_search_book_screen/admin_search_book_screen.dart';
import 'package:bookvies/screens/admin/admin_search_movie_screen.dart';
import 'package:bookvies/screens/admin/edit_book_screen/edit_book_screen.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/admin/edit_movie_screen/edit_movie_screen.dart';
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
import 'package:bookvies/screens/search_user_screen/search_user_screen.dart';
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
        var arg = routeSettings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => FavoriteGenresScreen(
                  skipButton: arg,
                ));
      case (PopularBookScreen.id):
        return MaterialPageRoute(builder: (_) => const PopularBookScreen());
      case (ExploreBooksScreen.id):
        return MaterialPageRoute(builder: (_) => const ExploreBooksScreen());
      case (ForgotPasswordScreen.id):
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case (MainScreen.id):
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case (SearchUserScreen.id):
        return MaterialPageRoute(builder: (_) => const SearchUserScreen());
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
        final String args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  userId: args,
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
      case (AdminEditBookScreen.id):
        final args = routeSettings.arguments as Book;
        return MaterialPageRoute(
            builder: (_) => AdminEditBookScreen(
                  book: args,
                ));
      case (AdminSearchBookScreen.id):
        return MaterialPageRoute(builder: (_) => const AdminSearchBookScreen());
      case (AdminAddBookScreen.id):
        return MaterialPageRoute(builder: (_) => const AdminAddBookScreen());
      case (AdminAddMovieScreen.id):
        return MaterialPageRoute(builder: (_) => const AdminAddMovieScreen());
      case (AdminSearchMovieScreen.id):
        return MaterialPageRoute(
            builder: (_) => const AdminSearchMovieScreen());
      case (EditMovieScreen.id):
        final args = routeSettings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => EditMovieScreen(movie: args));

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
