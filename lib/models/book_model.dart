// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/models/review_model.dart';

class Book extends Media {
  final String author;
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

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'reviews': reviews,
      'numberOfReviews': numberReviews,
      'averageRating': averageRating,
      'genres': genres,
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
        id: map['id'] ?? "",
        name: map['name'] ?? "",
        description: map['description'] ?? "",
        image: map['coverImg'] ?? "",
        reviews: map['reviews'] == null
            ? []
            : (map['reviews'] as List<dynamic>)
                .map((e) => Review.fromMap(e as Map<String, dynamic>))
                .toList(),
        numberReviews:
            map['numberOfReviews'] == null ? 0 : map['numberOfReviews'] as int,
        averageRating: map['averageRating'] == null
            ? 0.0
            : map['averageRating'].toDouble(),
        author: map['author'] ?? "Unknown",
        publisher: map['publisher'] as String?,
        isbn: map['isbn'] as String?,
        firstPublishDate: map['firstPublishDate'] == null
            ? null
            : (map['firstPublishDate'] as Timestamp).toDate(),
        pages: map['pages'] as int?,
        genres: map['genres'] == null
            ? []
            : List<String>.from(map['genres'].map((e) => e.toString())),
      );
    }
  }

  @override
  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  Book copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    List<Review>? reviews,
    int? numberReviews,
    double? averageRating,
    List<String>? genres,
    String? author,
    String? publisher,
    String? isbn,
    DateTime? firstPublishDate,
    int? pages,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      reviews: reviews ?? this.reviews,
      numberReviews: numberReviews ?? this.numberReviews,
      averageRating: averageRating ?? this.averageRating,
      genres: genres ?? this.genres,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      isbn: isbn ?? this.isbn,
      firstPublishDate: firstPublishDate ?? this.firstPublishDate,
      pages: pages ?? this.pages,
    );
  }
}
