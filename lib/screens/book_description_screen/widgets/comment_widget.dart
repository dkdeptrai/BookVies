import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(comment.userAvatarUrl),
              ),
              const SizedBox(width: 10),
              Text(comment.userName, style: AppStyles.commentUserNameText),
            ],
          ),
          const SizedBox(height: 10),
          Text(comment.content, style: AppStyles.commentContentText),
        ],
      ),
    );
  }
}
