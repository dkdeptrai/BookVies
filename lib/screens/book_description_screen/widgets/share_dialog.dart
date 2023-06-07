import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/screens/book_description_screen/widgets/user_info_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant/colors.dart';

class ShareDialog extends StatefulWidget {
  const ShareDialog({super.key, required this.reviewId});
  final String reviewId;
  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  late Future<List<Chat>> _chatList;

  Future<List<Chat>> _fetchChatList() async {
    final querySnapshot = await chatRef
        .where('usersId', arrayContains: firebaseAuth.currentUser!.uid)
        .orderBy('lastTime', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => Chat.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _chatList = _fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Share this review',
                style: AppStyles.reportDialogTitle,
              ),
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(AppAssets.icClose),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Share this review with your friends',
              style: AppStyles.reportSectionTitle,
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _chatList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final chat = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => _sendReviewRecommendation(
                          chat.docId, widget.reviewId),
                      child: Material(
                        child: UserInfoWidget(
                          userId: chat.usersId
                              .where((element) =>
                                  element != firebaseAuth.currentUser!.uid)
                              .first,
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ))
        ],
      ),
    );
  }

  _sendReviewRecommendation(String chatId, String reviewId) async {
    final batch = FirebaseFirestore.instance.batch();

    final chatDocRef =
        FirebaseFirestore.instance.collection('chat').doc(chatId);
    final messagesCollRef = chatDocRef.collection('messages');

    batch.set(
      messagesCollRef.doc(),
      {
        'type': 'review',
        'sendTime': DateTime.now(),
        'senderId': firebaseAuth.currentUser!.uid,
        'reviewId': reviewId,
        'read': false,
        'content': 'Send a review!',
      },
    );

    batch.update(
      chatDocRef,
      {
        'lastMessage': 'Sent a review!',
        'lastTime': DateTime.now(),
      },
    );
    await batch.commit();
    Navigator.pop(context);
  }
}
