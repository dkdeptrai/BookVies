// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookvies/models/review_model.dart';

class Media {
  String id;
  final String name;
  final String description;
  final String image;
  final List<Review> reviews;
  final int numberReviews;
  final double averageRating;
  final List<String> genres;

  Media({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.reviews,
    required this.numberReviews,
    required this.averageRating,
    required this.genres,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'numberReviews': numberReviews,
      'averageRating': averageRating,
      'genres': genres,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      reviews: map['reviews'] == null
          ? []
          : List<Review>.from(
              (map['reviews'] as List<int>).map<Review>(
                (x) => Review.fromMap(x as Map<String, dynamic>),
              ),
            ),
      numberReviews:
          map['numberReviews'] == null ? 0 : map['numberReviews'] as int,
      averageRating:
          map['averageRating'] == null ? 0.0 : map['averageRating'] as double,
      genres: map['genres'] == null
          ? []
          : (map['genres'] as String)
              .replaceAll(RegExp(r"[\[\]']"), "")
              .split(", "),
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) =>
      Media.fromMap(json.decode(source) as Map<String, dynamic>);
}
