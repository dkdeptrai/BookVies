// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/models/user_model.dart';

class Chat {
  final String id;
  final List<User> users;
  final Message lastMessage;
  final String status;
  final DateTime lastTime;
  Chat({
    required this.id,
    required this.users,
    required this.lastMessage,
    required this.status,
    required this.lastTime,
  });

  Chat copyWith({
    String? id,
    List<User>? users,
    Message? lastMessage,
    String? status,
    DateTime? lastTime,
  }) {
    return Chat(
      id: id ?? this.id,
      users: users ?? this.users,
      lastMessage: lastMessage ?? this.lastMessage,
      status: status ?? this.status,
      lastTime: lastTime ?? this.lastTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'users': users.map((x) => x.toMap()).toList(),
      'lastMessage': lastMessage.toMap(),
      'status': status,
      'lastTime': lastTime.millisecondsSinceEpoch,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as String,
      users: List<User>.from(
        (map['users'] as List<int>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastMessage: Message.fromMap(map['lastMessage'] as Map<String, dynamic>),
      status: map['status'] as String,
      lastTime: DateTime.fromMillisecondsSinceEpoch(map['lastTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(id: $id, users: $users, lastMessage: $lastMessage, status: $status, lastTime: $lastTime)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.users, users) &&
        other.lastMessage == lastMessage &&
        other.status == status &&
        other.lastTime == lastTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        users.hashCode ^
        lastMessage.hashCode ^
        status.hashCode ^
        lastTime.hashCode;
  }
}
