// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/models/media_model.dart';

class Movie extends Media {
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

  Movie(
      {required super.id,
      required super.name,
      required super.description,
      required super.image,
      required super.reviews,
      required super.numberReviews,
      required super.averageRating});
}
