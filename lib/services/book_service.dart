import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookService {
  final CollectionReference? booksRef;

  const BookService({this.booksRef});

  Future<List<Book>> getPopularBooks({required int limit}) async {
    List<Book> books = [];

    final ref = await (booksRef ?? FirebaseFirestore.instance.collection("books")).orderBy("averageRating", descending: true).limit(limit).get();

    books = ref.docs
        .map((e) => Book.fromMap(e.data() as Map<String, dynamic>).copyWith(
              id: e.id,
            ))
        .toList();

    return books;
  }

  Future<List<Book>> searchBooks({required String keyword, required int limit}) async {
    List<Book> books = [];

    final ref = await (booksRef ?? FirebaseFirestore.instance.collection("books"))
        .orderBy('name')
        // .where('name', isGreaterThanOrEqualTo: keyword)
        // .where('name', isLessThan: keyword + 'z')
        .startAt([keyword])
        .endAt(['$keyword\uf8ff'])
        .limit(10)
        .get();

    books = ref.docs.map((e) => Book.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id)).toList();

    return books;
  }

  Future<Map<String, dynamic>> getRecommendBooks({required BuildContext context, required int limit, DocumentSnapshot? lastDocument}) async {
    List<Book> books = [];
    QuerySnapshot snapshot;
    DocumentSnapshot? newLastDocument;
    final UserState userState = context.read<UserBloc>().state;

    if (userState is UserLoaded) {
      final UserModel user = userState.user;
      final favoriteGenres = List.from(userState.user.favoriteGenres);

      try {
        if (favoriteGenres.isEmpty) {
          // if there is no favorite genres, get random books
          snapshot = await (booksRef ?? FirebaseFirestore.instance.collection("books")).limit(limit).get();
        } else {
          if (lastDocument == null) {
            snapshot = await (booksRef ?? FirebaseFirestore.instance.collection("books"))
                .where("genres", arrayContainsAny: user.favoriteGenres)
                .limit(limit)
                .get();
          } else {
            snapshot = await (booksRef ?? FirebaseFirestore.instance.collection("books"))
                .where("genres", arrayContainsAny: user.favoriteGenres)
                .startAfterDocument(lastDocument)
                .limit(limit)
                .get();
          }
        }

        books = snapshot.docs.map((e) => Book.fromMap(e.data() as Map<String, dynamic>).copyWith(id: e.id)).toList();
        newLastDocument = snapshot.docs.last;
      } catch (error) {
        print("Get recommend books error: $error");
      }
    } else {
      print("Error getting recommendations books");
    }

    return {"books": books, "lastDocument": newLastDocument};
  }

  Future<void> updateBook({required Book book}) async {
    try {
      await (booksRef ?? FirebaseFirestore.instance.collection("books")).doc(book.id).update(book.toMap());
    } catch (error) {
      print("Update book error: $error");
    }
  }

  Future<Book?> getBookById({required String id}) async {
    try {
      final doc = await (booksRef ?? FirebaseFirestore.instance.collection("books")).doc(id).get();
      return Book.fromMap(doc.data() as Map<String, dynamic>).copyWith(id: doc.id);
    } catch (error) {
      print("Get book by id error: $error");
      return null;
    }
  }

  Future<void> deleteBook({required String id}) async {
    try {
      await (booksRef ?? FirebaseFirestore.instance.collection("books")).doc(id).delete();
    } catch (error) {
      print("Delete book error: $error");
    }
  }

  Future<void> addBook({required Book book}) async {
    try {
      final DocumentReference docRef = (booksRef ?? FirebaseFirestore.instance.collection("books")).doc();
      await docRef.set(book.copyWith(id: docRef.id).toMap());
    } catch (error) {
      print("Add book error: $error");
    }
  }
}
