part of 'admin_movies_bloc.dart';

abstract class AdminMoviesState extends Equatable {
  final List<Movie> movies;
  final DocumentSnapshot? lastDocumentSnapshot;

  const AdminMoviesState({this.movies = const [], this.lastDocumentSnapshot});

  @override
  List<Object?> get props => [movies, lastDocumentSnapshot];
}

class AdminMoviesInitial extends AdminMoviesState {}

class AdminMoviesLoading extends AdminMoviesState {
  const AdminMoviesLoading(
      {required List<Movie> movies,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(movies: movies, lastDocumentSnapshot: lastDocumentSnapshot);
}

class AdminMoviesLoaded extends AdminMoviesState {
  const AdminMoviesLoaded(
      {required List<Movie> movies,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(movies: movies, lastDocumentSnapshot: lastDocumentSnapshot);

  @override
  List<Object> get props => [movies];
}

class AdminMoviesError extends AdminMoviesState {
  final String message;
  const AdminMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
