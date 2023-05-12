import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool showSendTime;
  const MessageWidget({
    Key? key,
    required this.message,
    required this.showSendTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.senderId == currentUser!.uid;

    return Stack(
      children: [
        Align(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
