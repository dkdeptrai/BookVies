// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bookvies/models/media_model.dart';

class Book extends Media {
  final String author;
  final String publisher;
  final int pages;
  final DateTime publicationDate;
  Book({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.genres,
    required this.author,
    required this.publisher,
    required this.pages,
    required this.publicationDate,
    super.averageRating = 0,
    super.reviewsNum = 0,
  });

  static final bookList = [
    Book(
        id: "1",
        name: "Lesson in Chemistry",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis diam ac ipsum sagittis congue vitae et leo. Suspendisse potenti. Vivamus sodales eros dui, vitae pretium ligula eleifend et. Integer quis aliquet odio. Vestibulum molestie condimentum sem id elementum",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus",
        publisher: "Penguin Random House",
        publicationDate: DateTime(2022, 4, 24),
        pages: 123,
        genres: [
          'Horror',
          'Fantasy',
          'Vampires',
          'Fiction',
          'Paranormal',
          'Supernatural',
          'Urban Fantasy',
          'Gothic',
          'Historical Fiction',
          'Adult'
        ],
        reviewsNum: 1234),
    Book(
        id: "2",
        name: "Lesson in Chemistry",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis diam ac ipsum sagittis congue vitae et leo. Suspendisse potenti. Vivamus sodales eros dui, vitae pretium ligula eleifend et. Integer quis aliquet odio. Vestibulum molestie condimentum sem id elementum",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus",
        publisher: "Penguin Random House",
        publicationDate: DateTime(2022, 4, 24),
        pages: 123,
        genres: [
          'Horror',
          'Fantasy',
          'Vampires',
          'Fiction',
          'Paranormal',
          'Supernatural',
          'Urban Fantasy',
          'Gothic',
          'Historical Fiction',
          'Adult'
        ],
        reviewsNum: 1234),
    Book(
        id: "3",
        name: "Lesson in Chemistry",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis diam ac ipsum sagittis congue vitae et leo. Suspendisse potenti. Vivamus sodales eros dui, vitae pretium ligula eleifend et. Integer quis aliquet odio. Vestibulum molestie condimentum sem id elementum",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus",
        publisher: "Penguin Random House",
        publicationDate: DateTime(2022, 4, 24),
        pages: 123,
        genres: [
          'Horror',
          'Fantasy',
          'Vampires',
          'Fiction',
          'Paranormal',
          'Supernatural',
          'Urban Fantasy',
          'Gothic',
          'Historical Fiction',
          'Adult'
        ],
        reviewsNum: 1234),
  ];
}
