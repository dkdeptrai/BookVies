part of 'admin_newest_books_bloc.dart';

abstract class AdminNewestBooksState extends Equatable {
  const AdminNewestBooksState({
    this.newestBooks = const [],
    this.lastDocumentSnapshot,
  });
  final List<Book> newestBooks;
  final DocumentSnapshot? lastDocumentSnapshot;

  @override
  List<Object?> get props => [newestBooks, lastDocumentSnapshot];

  // void addAll(List<Book> newBooks) {
  //   newestBooks.addAll(newBooks);
  // }
}

class AdminNewestBooksInitial extends AdminNewestBooksState {}

class AdminNewestBooksLoading extends AdminNewestBooksState {
  const AdminNewestBooksLoading(
      {required List<Book> newestBooks,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(
            newestBooks: newestBooks,
            lastDocumentSnapshot: lastDocumentSnapshot);
}

class AdminNewestBooksLoaded extends AdminNewestBooksState {
  const AdminNewestBooksLoaded(
      {required List<Book> newestBooks,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(
            newestBooks: newestBooks,
            lastDocumentSnapshot: lastDocumentSnapshot);

  @override
  List<Object> get props => [newestBooks];
}

class AdminNewestBooksError extends AdminNewestBooksState {
  final String message;
  const AdminNewestBooksError({required this.message});

  @override
  List<Object> get props => [message];
}
