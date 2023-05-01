// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book extends Media {
  final String? author;
  final String? publisher;
  final String? isbn;
  final DateTime? firstPublishDate;
  final int? pages;
  Book({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.reviews,
    required super.numberReviews,
    required super.averageRating,
    required this.author,
    required this.publisher,
    required this.isbn,
    required this.firstPublishDate,
    required this.pages,
    required super.genres,
  });

  static final List<Book> bookList = [
    // Book(
    //     id: "1",
    //     name: "Lesson in Chemistry",
    //     description: "Hello",
    //     image:
    //         "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
    //     author: "Bonnie Garmus"),

    Book(
        id: "1",
        name: "Lesson in Chemistry",
        description: "Hello",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        reviews: [],
        numberReviews: 0,
        averageRating: 4.5,
        author: "Tien Vi",
        publisher: "Publisher",
        isbn: "123",
        firstPublishDate: DateTime.now(),
        pages: 100)
    // Book(
    //     id: "2",
    //     name: "Lesson in Chemistry",
    //     description: "Hello",
    //     image:
    //         "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
    //     author: "Bonnie Garmus"),
    // Book(
    //     id: "3",
    //     name: "Lesson in Chemistry",
    //     description: "Hello",
    //     image:
    //         "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
    //     author: "Bonnie Garmus"),
  ];

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'reviews': reviews,
      'numberReviews': numberReviews,
      'averageRating': averageRating,
      'author': author,
      'publisher': publisher,
      'isbn': isbn,
      'firstPublishDate': firstPublishDate,
      'pages': pages,
    };
  }

  factory Book.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Book(
          id: "N/A",
          name: "N/A",
          description: "N/A",
          image:
              "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
          reviews: [],
          numberReviews: 0,
          averageRating: 0,
          author: "N/A",
          publisher: "N/A",
          isbn: "N/A",
          firstPublishDate: DateTime(0, 0, 0),
          pages: 0,
          genres: []);
    } else {
      return Book(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        image: map['coverImg'] == null ? "" : map['coverImg'] as String,
        reviews: map['reviews'] == null
            ? []
            : (map['reviews'] as List<dynamic>)
                .map((e) => Review.fromMap(e as Map<String, dynamic>))
                .toList(),
        numberReviews:
            map['numberReviews'] == null ? 0 : map['numberReviews'] as int,
        averageRating: map['averageRating'] == null
            ? 0.0
            : map['averageRating'].toDouble(),
        author: map['author'] as String?,
        publisher: map['publisher'] as String?,
        isbn: map['isbn'] as String?,
        firstPublishDate: map['firstPublishDate'] == null
            ? null
            : (map['firstPublishDate'] as Timestamp).toDate(),
        pages: map['pages'] as int?,
        genres: map['genres'] == null
            ? []
            : (map['genres'] as String)
                .replaceAll(RegExp(r"[\[\]']"), "")
                .split(", "),
      );
    }
  }

  @override
  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
