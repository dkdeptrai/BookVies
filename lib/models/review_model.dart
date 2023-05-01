// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookvies/models/comment_model.dart';

class Review {
  final String id;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String mediaId;
  final int rating;
  final String title;
  final String description;
  final int upVoteNumber;
  final List<String> upVoteUsers;
  final int downVoteNumber;
  final List<String> downVoteUsers;
  final List<Comment> comments;
  final DateTime createdTime;
  final String privacy; // public, private

  Review(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.userAvatarUrl,
      required this.mediaId,
      required this.rating,
      required this.title,
      required this.description,
      required this.upVoteNumber,
      required this.upVoteUsers,
      required this.downVoteNumber,
      required this.downVoteUsers,
      required this.comments,
      required this.createdTime,
      required this.privacy});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'mediaId': mediaId,
      'rating': rating,
      'title': title,
      'description': description,
      'upVoteNumber': upVoteNumber,
      'upVoteUsers': upVoteUsers,
      'downVoteNumber': downVoteNumber,
      'downVoteUsers': downVoteUsers,
      'comments': comments.map((x) => x.toMap()).toList(),
      'createdTime': createdTime,
      'privacy': privacy
    };
  }

  static List<Review> reviews = [
    Review(
        id: "1",
        userId: "abc",
        userName: "Tien Vi",
        userAvatarUrl: "",
        mediaId: "1",
        rating: 4,
        title: "This book is very fascinated",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        upVoteNumber: 0,
        upVoteUsers: [],
        downVoteNumber: 0,
        downVoteUsers: [],
        comments: [],
        createdTime: DateTime.now(),
        privacy: 'public'),
  ];

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
        id: map['id'] as String,
        userId: map['userId'] as String,
        userName: map['userName'] as String,
        userAvatarUrl: map['userAvatarUrl'] as String,
        mediaId: map['mediaId'] as String,
        rating: map['rating'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        upVoteNumber: map['upVoteNumber'] as int,
        upVoteUsers: List<String>.from((map['upVoteUsers'] as List<String>)),
        downVoteNumber: map['downVoteNumber'] as int,
        downVoteUsers:
            List<String>.from((map['downVoteUsers'] as List<String>)),
        comments: List<Comment>.from(
          (map['comments'] as List<int>).map<Comment>(
            (x) => Comment.fromMap(x as Map<String, dynamic>),
          ),
        ),
        createdTime:
            DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
        privacy: map['privacy'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
