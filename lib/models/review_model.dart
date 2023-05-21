// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookvies/models/comment_model.dart';

class Review {
  final String id;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String mediaType;
  final String mediaId;
  final String? mediaName;
  final String? mediaImage;
  final String?
      mediaAuthor; // It's represent for both book author and movie director
  final int rating;
  final String title;
  final String description;
  final int upVoteNumber;
  final List<String> upVoteUsers;
  final int downVoteNumber;
  final List<String> downVoteUsers;
  List<Comment> comments;
  final DateTime createdTime;
  final String privacy; // public, private

  Review(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.userAvatarUrl,
      required this.mediaType,
      required this.mediaId,
      required this.mediaName,
      required this.mediaImage,
      required this.mediaAuthor,
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
      'mediaType': mediaType,
      'mediaId': mediaId,
      'mediaName': mediaName,
      'mediaImage': mediaImage,
      'mediaAuthor': mediaAuthor,
      'rating': rating,
      'title': title,
      'description': description,
      'upVoteNumber': upVoteNumber,
      'upVoteUsers': upVoteUsers,
      'downVoteNumber': downVoteNumber,
      'downVoteUsers': downVoteUsers,
      'comments': comments.map((x) => x.toJson()).toList(),
      'createdTime': createdTime.millisecondsSinceEpoch,
      'privacy': privacy,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userAvatarUrl: map['userAvatarUrl'] as String,
      mediaType: map['mediaType'] as String,
      mediaId: map['mediaId'] as String,
      mediaName: map['mediaName'] as String?,
      mediaImage: map['mediaImage'] as String?,
      mediaAuthor: map['mediaAuthor'] as String?,
      rating: map['rating'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      upVoteNumber: map['upVoteNumber'] as int,
      upVoteUsers: List<String>.from(map['upVoteUsers'] as List<dynamic>),
      downVoteNumber: map['downVoteNumber'] as int,
      downVoteUsers: List<String>.from(map['downVoteUsers'] as List<dynamic>),
      comments: List<Comment>.from(map['comments'] as List<dynamic>)
          .map<Comment>((x) => Comment.fromMap(
                x as Map<String, dynamic>,
              ))
          .toList(),
      createdTime:
          DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
      privacy: map['privacy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  Review copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatarUrl,
    String? mediaType,
    String? mediaId,
    String? mediaName,
    String? mediaImage,
    //? mediaAuthor,
    int? rating,
    String? title,
    String? description,
    int? upVoteNumber,
    List<String>? upVoteUsers,
    int? downVoteNumber,
    List<String>? downVoteUsers,
    List<Comment>? comments,
    DateTime? createdTime,
    String? privacy,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      mediaType: mediaType ?? this.mediaType,
      mediaId: mediaId ?? this.mediaId,
      mediaName: mediaName ?? this.mediaName,
      mediaImage: mediaImage ?? this.mediaImage,
      mediaAuthor: mediaAuthor ?? this.mediaAuthor,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      description: description ?? this.description,
      upVoteNumber: upVoteNumber ?? this.upVoteNumber,
      upVoteUsers: upVoteUsers ?? this.upVoteUsers,
      downVoteNumber: downVoteNumber ?? this.downVoteNumber,
      downVoteUsers: downVoteUsers ?? this.downVoteUsers,
      comments: comments ?? this.comments,
      createdTime: createdTime ?? this.createdTime,
      privacy: privacy ?? this.privacy,
    );
  }
}
