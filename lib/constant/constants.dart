class AppConstants {
  static const List<String> mediaType = ["BOOK", "MOVIE"];
}

enum MediaType { book, movie }

enum LibraryBookType { read, reading, toRead }

enum PrivacyValues { public, personal }

const Map<String, String> privacyText = {
  "public": "PUBLIC",
  "personal": "PERSONAL"
};
