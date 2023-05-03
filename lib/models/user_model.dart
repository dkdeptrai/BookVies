// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bookvies/models/chat_model.dart';

class User {
  final String name;
  final String image;
  final List<Chat> chats;
  User({
    required this.name,
    required this.image,
    required this.chats,
  });

  User copyWith({
    String? name,
    String? image,
    List<Chat>? chats,
  }) {
    return User(
      name: name ?? this.name,
      image: image ?? this.image,
      chats: chats ?? this.chats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'chats': chats.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      image: map['image'] as String,
      chats: List<Chat>.from(
        (map['chats'] as List<int>).map<Chat>(
          (x) => Chat.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, image: $image, chats: $chats)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        listEquals(other.chats, chats);
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ chats.hashCode;
}
