import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (showSendTime)
              Column(
                children: [
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('dd MMM kk:mm').format(message.sendTime),
                    style: AppStyles.primaryTextStyle,
                  ),
                ],
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: AppStyles.chatMessageDecoration,
              margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.content,
                style: const TextStyle(color: AppColors.primaryTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
