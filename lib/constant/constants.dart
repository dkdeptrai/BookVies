class AppConstants {
  static const List<String> mediaType = ["BOOK", "MOVIE"];
}

enum MediaType { book, movie }

enum LibraryBookType { read, reading, toRead }

const Map<String, String> libraryBookTypeText = {
  "read": "Read",
  "reading": "Reading",
  "toRead": "To Read",
};

enum PrivacyValues { public, personal }

const Map<String, String> privacyText = {
  "public": "PUBLIC",
  "personal": "PERSONAL"
};
