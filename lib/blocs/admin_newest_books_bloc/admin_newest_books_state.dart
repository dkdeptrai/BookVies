part of 'admin_newest_books_bloc.dart';

abstract class AdminNewestBooksState extends Equatable {
  AdminNewestBooksState({
    this.newestBooks = const [],
    this.lastDocumentSnapshot,
  });
  List<Book> newestBooks;
  DocumentSnapshot? lastDocumentSnapshot;

  @override
  List<Object?> get props => [newestBooks, lastDocumentSnapshot];

  void addAll(List<Book> newBooks) {
    newestBooks.addAll(newBooks);
  }
}

class AdminNewestBooksInitial extends AdminNewestBooksState {}

class AdminNewestBooksLoading extends AdminNewestBooksState {
  AdminNewestBooksLoading(
      {required List<Book> newestBooks,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(
            newestBooks: newestBooks,
            lastDocumentSnapshot: lastDocumentSnapshot);
}

class AdminNewestBooksLoaded extends AdminNewestBooksState {
  AdminNewestBooksLoaded(
      {required List<Book> newestBooks,
      required DocumentSnapshot? lastDocumentSnapshot})
      : super(
            newestBooks: newestBooks,
            lastDocumentSnapshot: lastDocumentSnapshot);
}

class AdminNewestBooksError extends AdminNewestBooksState {
  final String message;
  AdminNewestBooksError({required this.message});

  @override
  List<Object> get props => [message];
}
