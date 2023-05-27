import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
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

  Future<List<Book>> getRecommendBooks(
      {required BuildContext context, required int limit}) async {
    List<Book> books = [];
    try {
      final UserState userState = context.read<UserBloc>().state;
      if (userState is UserLoaded) {
        final UserModel user = userState.user;
        final ref = await booksRef
            .where("genres", arrayContainsAny: user.favoriteGenres)
            .limit(limit)
            .get();

        books = ref.docs
            .map((e) => Book.fromMap(e.data() as Map<String, dynamic>)
                .copyWith(id: e.id))
            .toList();
      }
    } catch (error) {
      print("Get recommend books error: $error");
    }

    return books;
  }
}
