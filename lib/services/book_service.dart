import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookService {
  Future<List<Book>> getPopularBooks({required int limit}) async {
    List<Book> books = [];

    final ref = await booksRef
        .orderBy("averageRating", descending: true)
        .limit(limit)
        .get();

    books = ref.docs
        .map((e) => Book.fromMap(e.data() as Map<String, dynamic>).copyWith(
              id: e.id,
            ))
        .toList();

    return books;
  }

  Future<List<Book>> searchBooks(
      {required String keyword, required int limit}) async {
    List<Book> books = [];

    final ref = await booksRef
        .orderBy('name')
        // .where('name', isGreaterThanOrEqualTo: keyword)
        // .where('name', isLessThan: keyword + 'z')
        .startAt([keyword])
        .endAt(['$keyword\uf8ff'])
        .limit(10)
        .get();

    books = ref.docs
        .map((e) =>
            Book.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id))
        .toList();

    return books;
  }

  Future<Map<String, dynamic>> getRecommendBooks(
      {required BuildContext context,
      required int limit,
      DocumentSnapshot? lastDocument}) async {
    List<Book> books = [];
    late final QuerySnapshot snapshot;

    try {
      final UserState userState = context.read<UserBloc>().state;
      if (userState is UserLoaded) {
        final UserModel user = userState.user;
        if (lastDocument == null) {
          snapshot = await booksRef
              .where("genres", arrayContainsAny: user.favoriteGenres)
              .limit(limit)
              .get();
        } else {
          snapshot = await booksRef
              .where("genres", arrayContainsAny: user.favoriteGenres)
              .startAfterDocument(lastDocument)
              .limit(limit)
              .get();
        }

        books = snapshot.docs
            .map((e) => Book.fromMap(e.data() as Map<String, dynamic>)
                .copyWith(id: e.id))
            .toList();
      }
    } catch (error) {
      print("Get recommend books error: $error");
    }

    return {"books": books, "lastDocument": snapshot.docs.last};
  }

  Future<void> updateBook({required Book book}) async {
    try {
      await booksRef.doc(book.id).update(book.toMap());
    } catch (error) {
      print("Update book error: $error");
    }
  }

  Future<Book?> getBookById({required String id}) async {
    try {
      final doc = await booksRef.doc(id).get();
      return Book.fromMap(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    } catch (error) {
      print("Get book by id error: $error");
      return null;
    }
  }

  Future<void> deleteBook({required String id}) async {
    try {
      await booksRef.doc(id).delete();
    } catch (error) {
      print("Delete book error: $error");
    }
  }

  Future<void> addBook({required Book book}) async {
    try {
      final DocumentReference docRef = booksRef.doc();
      await docRef.set(book.copyWith(id: docRef.id).toMap());
    } catch (error) {
      print("Add book error: $error");
    }
  }
}
