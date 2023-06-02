import 'package:bloc/bloc.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:bookvies/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'admin_newest_books_event.dart';
part 'admin_newest_books_state.dart';

class AdminNewestBooksBloc
    extends Bloc<AdminNewestBooksEvent, AdminNewestBooksState> {
  AdminNewestBooksBloc() : super(AdminNewestBooksInitial()) {
    on<LoadAdminNewestBooks>(_onLoadNewestBooks);
    on<UpdateBook>(_onUpdateBook);
    on<DeleteBook>(_onDeleteBook);
  }

  _onLoadNewestBooks(event, emit) async {
    emit(AdminNewestBooksLoading(
        newestBooks: state.newestBooks,
        lastDocumentSnapshot: state.lastDocumentSnapshot));
    try {
      late final QuerySnapshot snapshot;
      late final DocumentSnapshot lastDocumentSnapshot;

      if (state.lastDocumentSnapshot == null) {
        snapshot = await booksRef
            .orderBy("publishDate", descending: true)
            .limit(20)
            .get();
      } else {
        snapshot = await booksRef
            .orderBy("publishDate", descending: true)
            .startAfterDocument(state.lastDocumentSnapshot!)
            .limit(20)
            .get();
      }
      lastDocumentSnapshot = snapshot.docs.last;
      List<Book> newestBooks = snapshot.docs.map((e) {
        return Book.fromMap(e.data() as Map<String, dynamic>)
            .copyWith(id: e.id);
      }).toList();

      emit(AdminNewestBooksLoaded(
          newestBooks: [...state.newestBooks, ...newestBooks],
          lastDocumentSnapshot: lastDocumentSnapshot));
    } catch (error) {
      emit(AdminNewestBooksError(message: error.toString()));
      print("Load newest book error: $error");
    }
  }

  _onUpdateBook(event, emit) async {
    try {
      BookService().updateBook(book: event.book);

      final int index = state.newestBooks
          .indexWhere((element) => element.id == event.book.id);
      final Book? bookAfterUpdateOnFb =
          await BookService().getBookById(id: event.book.id);
      if (bookAfterUpdateOnFb != null) {
        final newList = List<Book>.from(state.newestBooks);
        newList[index] = bookAfterUpdateOnFb;
        emit(AdminNewestBooksLoaded(
            newestBooks: newList,
            lastDocumentSnapshot: state.lastDocumentSnapshot));
      }
      showSnackBar(context: event.context, message: "Update successfully");
    } catch (error) {
      print("Update book error: $error");
    }
  }

  _onDeleteBook(event, emit) async {
    try {
      await BookService().deleteBook(id: event.bookId);

      final int index =
          state.newestBooks.indexWhere((element) => element.id == event.bookId);
      final newList = List<Book>.from(state.newestBooks);
      newList.removeAt(index);
      emit(AdminNewestBooksLoaded(
          newestBooks: newList,
          lastDocumentSnapshot: state.lastDocumentSnapshot));
      showSnackBar(context: event.context, message: "Delete successfully");
    } catch (error) {
      print(error);
    }
  }
}
