import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieService {
  Future<Movie> getMovieById({required String movieId}) async {
    try {
      final snapshot = await moviesRef.doc(movieId).get();
      return Movie.fromMap(snapshot.data() as Map<String, dynamic>)
          .copyWith(id: snapshot.id);
    } catch (error) {
      print("Get movie by id error: $error");
      rethrow;
    }
  }

  Future<void> updateMovie({required Movie movie}) async {
    try {
      await moviesRef.doc(movie.id).update(movie.toMap());
    } catch (error) {
      print("Update movie error: $error");
      rethrow;
    }
  }

  Future<void> deleteMovie({required String movieId}) async {
    try {
      await moviesRef.doc(movieId).delete();
    } catch (error) {
      print("Delete movie error: $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTopRatingMovies(
      {required int limit, DocumentSnapshot? lastDocument}) async {
    late final QuerySnapshot snapshot;
    try {
      if (lastDocument == null) {
        snapshot = await moviesRef.orderBy("averageRating").limit(limit).get();
      } else {
        snapshot = await moviesRef
            .orderBy("averageRating")
            .startAfterDocument(lastDocument)
            .limit(limit)
            .get();
      }

      return {
        "movies": snapshot.docs
            .map((doc) => Movie.fromMap(doc.data() as Map<String, dynamic>)
                .copyWith(id: doc.id))
            .toList(),
        "lastDocument": snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
      };
    } catch (error) {
      print("Get top rating movies error: $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRecommendMovies({
    required BuildContext context,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    late final QuerySnapshot snapshot;

    final userState = context.read<UserBloc>().state;
    if (userState is UserLoaded) {
      try {
        if (lastDocument == null) {
          snapshot = await moviesRef
              .where("genres", arrayContainsAny: userState.user.favoriteGenres)
              .limit(limit)
              .get();
        } else {
          snapshot = await moviesRef
              .where("genres", arrayContainsAny: userState.user.favoriteGenres)
              .startAfterDocument(lastDocument)
              .limit(limit)
              .get();
        }
      } catch (error) {
        print("Get recommend movies error: $error");
        rethrow;
      }
    } else {
      showSnackBar(
          context: context, message: "Something when wrong. Please try again");
    }

    return {
      "movies": snapshot.docs.isEmpty ? [] : snapshot.docs
          .map((doc) => Movie.fromMap(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id))
          .toList(),
      "lastDocument": snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
    };
  }

  Future<List<Movie>> searchMovies(
      {required String keyword, required int limit}) async {
    List<Movie> movies = [];

    final snapshot = await moviesRef
        .orderBy('name')
        // .where('name', isGreaterThanOrEqualTo: keyword)
        // .where('name', isLessThan: keyword + 'z')
        .startAt([keyword])
        .endAt(['$keyword\uf8ff'])
        .limit(10)
        .get();

    movies = snapshot.docs
        .map((e) =>
            Movie.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id))
        .toList();

    return movies;
  }
}
