import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String senderId;
  final String content;
  final DateTime sendTime;
  final String type;
  final String reviewId;
  final bool read;
  Message({
    required this.senderId,
    required this.content,
    required this.sendTime,
    required this.type,
    this.reviewId = '',
    required this.read,
  });

  Message copyWith({
    String? senderId,
    String? content,
    DateTime? sendTime,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      sendTime: sendTime ?? this.sendTime,
      type: type,
      read: read,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'content': content,
      'sendTime': sendTime.millisecondsSinceEpoch,
      'read': read,
      'type': type,
      'reviewId': reviewId,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      content: map['content'] ?? "",
      sendTime: (map['sendTime'] as Timestamp).toDate(),
      type: map['type'] ?? 'text',
      reviewId: map['reviewId'] ?? '',
      read: map['read'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Message(senderId: $senderId, content: $content, sendTime: $sendTime, type: $type, reviewId: $reviewId, read: $read)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.content == content &&
        other.sendTime == sendTime &&
        other.type == type &&
        other.reviewId == reviewId &&
        other.read == read;
  }

  @override
  int get hashCode =>
      senderId.hashCode ^
      content.hashCode ^
      sendTime.hashCode ^
      read.hashCode ^
      reviewId.hashCode ^
      type.hashCode;
}
