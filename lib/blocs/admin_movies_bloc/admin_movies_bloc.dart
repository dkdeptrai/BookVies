import 'package:bloc/bloc.dart';
import 'package:bookvies/models/movie_model.dart';
import 'package:bookvies/services/movie_service.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'admin_movies_event.dart';
part 'admin_movies_state.dart';

class AdminMoviesBloc extends Bloc<AdminMoviesEvent, AdminMoviesState> {
  AdminMoviesBloc() : super(AdminMoviesInitial()) {
    on<LoadAdminMovies>(_onLoadAdminMovies);
    on<UpdateMovie>(_onUpdateMovie);
    on<DeleteMovie>(_onDeleteMovie);
    on<InsertMovie>(_onInsertMovie);
  }

  _onLoadAdminMovies(event, emit) async {
    emit(AdminMoviesLoading(
        movies: state.movies,
        lastDocumentSnapshot: state.lastDocumentSnapshot));
    try {
      late final QuerySnapshot snapshot;
      late final DocumentSnapshot lastDocumentSnapshot;
      if (state.lastDocumentSnapshot == null) {
        snapshot = await FirebaseFirestore.instance
            .collection("movies")
            .orderBy("releaseYear")
            .limit(20)
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection("movies")
            .orderBy("releaseYear")
            .startAfterDocument(state.lastDocumentSnapshot!)
            .limit(20)
            .get();
      }
      lastDocumentSnapshot = snapshot.docs.last;

      emit(AdminMoviesLoaded(
          movies: snapshot.docs
              .map((e) => Movie.fromMap(e.data() as Map<String, dynamic>))
              .toList(),
          lastDocumentSnapshot: lastDocumentSnapshot));
    } catch (e) {
      emit(AdminMoviesError(message: e.toString()));
    }
  }

  _onUpdateMovie(event, emit) async {
    try {
      await MovieService().updateMovie(movie: event.movie);

      final int index =
          state.movies.indexWhere((element) => element.id == event.movie.id);
      List<Movie> movies = List<Movie>.from(state.movies);
      movies[index] = event.movie;

      emit(AdminMoviesLoaded(
          movies: movies, lastDocumentSnapshot: state.lastDocumentSnapshot));

      showSnackBar(context: event.context, message: "Update successfully");
    } catch (error) {
      print("Update movie error: $error");
      rethrow;
    }
  }

  _onDeleteMovie(event, emit) async {
    try {
      await MovieService().deleteMovie(movieId: event.movieId);

      final int index =
          state.movies.indexWhere((element) => element.id == event.movieId);
      List<Movie> movies = List<Movie>.from(state.movies);
      movies.removeAt(index);

      emit(AdminMoviesLoaded(
          movies: movies, lastDocumentSnapshot: state.lastDocumentSnapshot));
    } catch (error) {
      print("Delete movie error: $error");
      rethrow;
    }
  }

  _onInsertMovie(event, emit) {
    emit(AdminMoviesLoaded(
        movies: [event.movie, ...state.movies],
        lastDocumentSnapshot: state.lastDocumentSnapshot));
  }
}
