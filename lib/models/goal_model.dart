import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Goal {
  String id;
  String type;
  DateTime startDate;
  DateTime? endDate;
  String status;
  int amount;
  int finishedAmount;
  Goal({
    required this.id,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.amount,
    required this.finishedAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'status': status,
      'amount': amount,
      'finishedAmount': finishedAmount,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] as String,
      type: map['type'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int)
          : null,
      status: map['status'] as String,
      amount: map['amount'] as int,
      finishedAmount: map['finishedAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) =>
      Goal.fromMap(json.decode(source) as Map<String, dynamic>);
}
