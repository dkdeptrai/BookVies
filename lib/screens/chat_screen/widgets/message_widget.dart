import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/models/review_model.dart';
import 'package:bookvies/screens/profile_screen/widgets/review_overview_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatefulWidget {
  final Message message;
  final bool showSendTime;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.showSendTime,
  }) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  Future<Review>? _futureReview;
  Future<Review> _fetchReview(String reviewId) async {
    return await reviewsRef.doc(reviewId).get().then((doc) {
      return Review.fromMap(doc.data()! as Map<String, dynamic>);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.message.type == 'review') {
      _futureReview = _fetchReview(widget.message.reviewId);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser =
        widget.message.senderId == firebaseAuth.currentUser!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (widget.showSendTime)
              Column(
                children: [
                  const SizedBox(height: 6),
                  Text(
                    DateFormat('dd MMM kk:mm').format(widget.message.sendTime),
                    style: AppStyles.primaryTextStyle,
                  ),
                ],
              ),
            if (widget.message.type == 'review' && _futureReview != null)
              FutureBuilder(
                future: _futureReview,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ReviewOverviewWidget(review: snapshot.data as Review);
                },
              )
            else
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: AppStyles.chatMessageDecoration,
                margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.message.content,
                  style: const TextStyle(color: AppColors.primaryTextColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
