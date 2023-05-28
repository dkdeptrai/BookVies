// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Chat {
  final String docId;
  final String id;
  final DateTime lastTime;
  final List<String> usersId;
  final bool read;
  Chat({
    required this.docId,
    required this.id,
    required this.lastTime,
    required this.usersId,
    required this.read,
  });

  Chat copyWith({
    String? docId,
    String? id,
    DateTime? lastTime,
    List<String>? usersId,
    bool? read,
  }) {
    return Chat(
      docId: docId ?? this.docId,
      id: id ?? this.id,
      lastTime: lastTime ?? this.lastTime,
      usersId: usersId ?? this.usersId,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'id': id,
      'lastTime': lastTime.millisecondsSinceEpoch,
      'usersId': usersId,
      'read': read,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map, String docId) {
    return Chat(
      docId: docId,
      id: map['id'] as String,
      lastTime: (map['lastTime'] as Timestamp).toDate(),
      usersId: List<String>.from(
        (map['usersId']),
      ),
      read: map['read'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source, String docId) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>, docId);

  @override
  String toString() {
    return 'Chat(docId: $docId, id: $id, lastTime: $lastTime, usersId: $usersId, read: $read)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.id == id &&
        other.lastTime == lastTime &&
        listEquals(other.usersId, usersId) &&
        other.read == read;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        id.hashCode ^
        lastTime.hashCode ^
        usersId.hashCode ^
        read.hashCode;
  }
}
