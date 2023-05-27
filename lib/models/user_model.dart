import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String name;
  String description;
  String email;
  String imageUrl;
  List<String> favoriteGenres;
  List<String> followers;
  List<String> following;
  UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.imageUrl,
    required this.favoriteGenres,
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
      'favoriteGenres': favoriteGenres,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      name: map['name'] as String,
      description: map['description'] ?? "",
      email: map['email'] ?? "",
      imageUrl: map['imageUrl'] as String,
      favoriteGenres: map['favoriteGenres'] == null
          ? []
          : List<String>.from(map['favoriteGenres'].map((e) => e.toString())),
      followers: map['followers'] == null
          ? []
          : List<String>.from(map['followers'] as List<String>),
      following: map['following'] == null
          ? []
          : List<String>.from(map['following'] as List<String>),
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
    List<String>? favoriteGenres,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
