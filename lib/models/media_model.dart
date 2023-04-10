class Media {
  final String id;
  final String name;
  final String description;
  final String image;
  final double averageRating;

  Media({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.averageRating = 0,
  });
}
