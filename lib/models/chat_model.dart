// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Chat {
  final String id;
  final DateTime lastTime;
  final List<String> usersId;
  Chat({
    required this.id,
    required this.lastTime,
    required this.usersId,
  });

  Chat copyWith({
    String? id,
    DateTime? lastTime,
    List<String>? usersId,
  }) {
    return Chat(
      id: id ?? this.id,
      lastTime: lastTime ?? this.lastTime,
      usersId: usersId ?? this.usersId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lastTime': lastTime.millisecondsSinceEpoch,
      'usersId': usersId,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] as String,
      lastTime: (map['lastTime'] as Timestamp).toDate(),
      usersId: List<String>.from(
        (map['usersId']),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Chat(id: $id, lastTime: $lastTime, usersId: $usersId)';

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.lastTime == lastTime &&
        listEquals(other.usersId, usersId);
  }

  @override
  int get hashCode => id.hashCode ^ lastTime.hashCode ^ usersId.hashCode;
}
