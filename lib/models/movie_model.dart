// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookvies/models/media_model.dart';
import 'package:bookvies/models/review_model.dart';

class Movie extends Media {
  final List<String> director;
  final String rating;
  final int duration; // minutes
  final int releaseYear;
  final List<String> actors;

  static final List<Movie> movieList = [
    // Movie(
    //     id: "1",
    //     name: "No way home",
    //     description: "",
    //     image:
    //         "https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg"),
    // Movie(
    //     id: "2",
    //     name: "John Wick 4",
    //     description: "",
    //     image:
    //         "https://e1.pxfuel.com/desktop-wallpaper/300/585/desktop-wallpaper-john-wick-chapter-4-poster-john-wick.jpg"),
    // Movie(
    //     id: "3",
    //     name: "Captain Marvel",
    //     description: "",
    //     image:
    //         "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_FMjpg_UX1000_.jpg")
  ];

  Movie({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.reviews,
    required super.numberReviews,
    required super.averageRating,
    required super.genres,
    required this.director,
    required this.rating,
    required this.duration,
    required this.releaseYear,
    required this.actors,
  });

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
      'genres': genres,
      'director': director,
      'rating': rating,
      'duration': duration,
      'releaseYear': releaseYear,
      'actors': actors,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      reviews: [],
      numberReviews: map['numberReviews'] ?? 0,
      averageRating:
          map['averageRating'] == null ? 0.0 : map['averageRating'].toDouble(),
      genres: List<String>.from((map['genres'].map((e) => e.toString()))),
      director: List<String>.from((map['director'].map((e) => e.toString()))),
      rating: map['rating'] as String,
      duration: map['duration'] as int,
      releaseYear: map['releaseYear'] as int,
      actors: List<String>.from((map['actors'].map((e) => e.toString()))),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Movie copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    List<Review>? reviews,
    int? numberReviews,
    double? averageRating,
    List<String>? genres,
    List<String>? director,
    String? rating,
    int? duration,
    int? releaseYear,
    List<String>? actors,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      reviews: reviews ?? this.reviews,
      numberReviews: numberReviews ?? this.numberReviews,
      averageRating: averageRating ?? this.averageRating,
      genres: genres ?? this.genres,
      director: director ?? this.director,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      releaseYear: releaseYear ?? this.releaseYear,
      actors: actors ?? this.actors,
    );
  }
}
