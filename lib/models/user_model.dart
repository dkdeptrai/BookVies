import 'dart:convert';

import 'package:bookvies/constant/constants.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String name;
  String description;
  String email;
  String imageUrl;
  String type;
  List<String> favoriteGenres;
  List<String> followers;
  List<String> following;
  UserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.imageUrl,
    required this.type,
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
      'type': type,
      'favoriteGenres': favoriteGenres,
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
      type: map['type'] ?? UserType.user.name,
      favoriteGenres: map['favoriteGenres'] == null
          ? []
          : List<String>.from(map['favoriteGenres'].map((e) => e.toString())),
      followers: map['followers'] == null
          ? []
          : List<String>.from(map['followers'].map((e) => e.toString())),
      following: map['following'] == null
          ? []
          : List<String>.from(map['following'].map((e) => e.toString())),
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
    String? type,
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
      type: type ?? this.type,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
