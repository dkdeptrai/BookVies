// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/screens/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/bookvies_user_model.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({
    Key? key,
    required this.chat,
  }) : super(key: key);
  Stream<BookviesUser> getChatPartner() async* {
    String partnerId = chat.usersId.where((id) => id != currentUser!.uid).first;
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(partnerId)
        .snapshots()
        .map((userSnapshot) =>
            BookviesUser.fromMap(userSnapshot.data() as Map<String, dynamic>));
  }

  Stream<Message> getLastMessage() async* {
    yield* FirebaseFirestore.instance
        .collection('chat')
        .doc(chat.docId)
        .collection('messages')
        .orderBy('sendTime', descending: true)
        .limit(1)
        .snapshots()
        .map((messageSnapshot) {
      if (messageSnapshot.docs.isEmpty) {
        return Message(
            content: '', senderId: '', sendTime: DateTime.now(), read: true);
      }
      DocumentSnapshot messageDoc = messageSnapshot.docs.first;
      return Message.fromMap(messageDoc.data() as Map<String, dynamic>);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Rx.combineLatest2(getChatPartner(), getLastMessage(),
          (BookviesUser partner, Message lastMessage) {
        return {'partner': partner, 'lastMessage': lastMessage};
      }),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        BookviesUser partner = snapshot.data!['partner'] as BookviesUser;
        Message lastMessage = snapshot.data!['lastMessage'] as Message;
        if (lastMessage.content == '') {
          return Container();
        }
        String subtitle = lastMessage.senderId == currentUser!.uid
            ? "You: ${lastMessage.content}"
            : "${partner.name}: ${lastMessage.content}";
        return Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.fromLTRB(7, 5, 5, 7),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                AppStyles.primaryShadow,
              ],
            ),
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                ChatScreen.id,
                arguments: chat,
              ),
              trailing: (!lastMessage.read &&
                      lastMessage.senderId != currentUser!.uid)
                  ? SvgPicture.asset(AppAssets.icUnreadMessage)
                  : null,
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(partner.imageUrl),
              ),
              title: Text(
                partner.name,
                style: (!lastMessage.read &&
                        lastMessage.senderId != currentUser!.uid)
                    ? const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)
                    : const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
              ),
              subtitle: Text(
                subtitle,
                maxLines: 1,
                style: (!lastMessage.read &&
                        lastMessage.senderId != currentUser!.uid)
                    ? const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )
                    : const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryTextColor,
                      ),
              ),
            ));
      },
    );
  }
}
