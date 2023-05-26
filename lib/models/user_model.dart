import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String name;
  String description;
  String email;
  String imageUrl;
  List<String> favoriteBookGenres;
  List<String> favoriteMovieGenres;
  List<String> followers;
  List<String> following;
  UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.imageUrl,
    required this.favoriteBookGenres,
    required this.favoriteMovieGenres,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'email': email,
      'imageUrl': imageUrl,
      'favoriteBookGenres': favoriteBookGenres,
      'favoriteMovieGenres': favoriteMovieGenres,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'] ?? "",
      name: map['name'] as String,
      description: map['description'] ?? "",
      email: map['email'] ?? "",
      imageUrl: map['imageUrl'] as String,
      favoriteBookGenres: map['favoriteBookGenres'] == null
          ? []
          : List<String>.from((map['favoriteBookGenres'] as List<String>)),
      favoriteMovieGenres: map['favoriteMovieGenres'] == null
          ? []
          : List<String>.from((map['favoriteMovieGenres'] as List<String>)),
      followers: map['followers'] == null
          ? []
          : List<String>.from(map['followers'] as List<String>),
      following: map['following'] == null
          ? []
          : List<String>.from(map['following'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? description,
    String? email,
    String? imageUrl,
    List<String>? favoriteBookGenres,
    List<String>? favoriteMovieGenres,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      favoriteBookGenres: favoriteBookGenres ?? this.favoriteBookGenres,
      favoriteMovieGenres: favoriteMovieGenres ?? this.favoriteMovieGenres,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
