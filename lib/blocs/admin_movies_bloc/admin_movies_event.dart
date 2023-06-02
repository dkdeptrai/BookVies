part of 'admin_movies_bloc.dart';

abstract class AdminMoviesEvent extends Equatable {
  const AdminMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadAdminMovies extends AdminMoviesEvent {}

class UpdateMovie extends AdminMoviesEvent {
  final Movie movie;
  final BuildContext context;
  const UpdateMovie({required this.movie, required this.context});
}

class DeleteMovie extends AdminMoviesEvent {
  final String movieId;
  final BuildContext context;

  const DeleteMovie({required this.movieId, required this.context});
}

class InsertMovie extends AdminMoviesEvent {
  final Movie movie;
  final BuildContext context;

  const InsertMovie({required this.movie, required this.context});
}
