// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/models/media_model.dart';

class Book extends Media {
  final String author;
  Book({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required this.author,
  });

  static final bookList = [
    Book(
        id: "1",
        name: "Lesson in Chemistry",
        description: "Hello",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus"),
    Book(
        id: "2",
        name: "Lesson in Chemistry",
        description: "Hello",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus"),
    Book(
        id: "3",
        name: "Lesson in Chemistry",
        description: "Hello",
        image:
            "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71yNgTMEcpL._AC_UF1000,1000_QL80_.jpg",
        author: "Bonnie Garmus"),
  ];
}
