// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookviesUser {
  final String name;
  final String imageUrl;
  final String description;
  BookviesUser({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  BookviesUser copyWith({
    String? name,
    String? imageUrl,
    String? description,
  }) {
    return BookviesUser(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory BookviesUser.fromMap(Map<String, dynamic> map) {
    return BookviesUser(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookviesUser.fromJson(String source) =>
      BookviesUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BookviesUser(name: $name, imageUrl: $imageUrl, description: $description)';

  @override
  bool operator ==(covariant BookviesUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode ^ description.hashCode;
}
