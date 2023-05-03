import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String id;
  final String senderId;
  final String message;
  final DateTime sendTime;
  Message({
    required this.id,
    required this.senderId,
    required this.message,
    required this.sendTime,
  });

  Message copyWith({
    String? id,
    String? senderId,
    String? message,
    DateTime? sendTime,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      sendTime: sendTime ?? this.sendTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'message': message,
      'sendTime': sendTime.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      message: map['message'] as String,
      sendTime: DateTime.fromMillisecondsSinceEpoch(map['sendTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, message: $message, sendTime: $sendTime)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.senderId == senderId &&
        other.message == message &&
        other.sendTime == sendTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        message.hashCode ^
        sendTime.hashCode;
  }
}
