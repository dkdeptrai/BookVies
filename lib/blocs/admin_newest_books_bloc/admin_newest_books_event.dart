part of 'admin_newest_books_bloc.dart';

abstract class AdminNewestBooksEvent extends Equatable {
  const AdminNewestBooksEvent();

  @override
  List<Object> get props => [];
}

class LoadAdminNewestBooks extends AdminNewestBooksEvent {}

class UpdateBook extends AdminNewestBooksEvent {
  final Book book;
  final BuildContext context;
  const UpdateBook({required this.book, required this.context});
}

class DeleteBook extends AdminNewestBooksEvent {
  final String bookId;
  final BuildContext context;

  const DeleteBook({required this.bookId, required this.context});
}
