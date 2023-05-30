class AppConstants {
  static const List<String> mediaType = ["BOOK", "MOVIE"];
  static const List<String> bookGenres = [
    "Romance",
    "Mystery",
    "Science Fiction",
    "Horror",
    "Historical Fiction",
    "Young Adult",
    "Non-Fiction",
    "Children"
  ];
}

enum UserType { user, admin }

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

enum GoalStatus { inProgress, finished }

enum GoalType { reading, watching }
