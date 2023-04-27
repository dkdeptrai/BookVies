class Media {
  final String id;
  final String name;
  final String description;
  final String image;
  final double averageRating;
  final int reviewsNum;
  final List<String> genres;

  Media({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.averageRating = 0,
    this.reviewsNum = 0,
    required this.genres,
  });
}
