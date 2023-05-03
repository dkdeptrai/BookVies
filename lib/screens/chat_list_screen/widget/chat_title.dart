// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/bookvies_user_model.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/message_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({
    super.key,
    required this.chat,
  });
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
        .where('id', isEqualTo: chat.id)
        .limit(1)
        .snapshots()
        .asyncMap((messagesSnapshot) async {
      if (messagesSnapshot.docs.isEmpty) {
        return Message(
            content: 'No messages yet', senderId: '', sendTime: DateTime.now());
      }
      DocumentSnapshot chatDoc = messagesSnapshot.docs.first;
      QuerySnapshot messageSnapshot = await chatDoc.reference
          .collection('messages')
          .orderBy('sendTime', descending: true)
          .limit(1)
          .get();
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
          return const Text('Error: \${snapshot.error}');
        }
        BookviesUser partner = snapshot.data!['partner'] as BookviesUser;
        Message lastMessage = snapshot.data!['lastMessage'] as Message;
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
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(partner.imageUrl),
              ),
              title: Text(
                partner.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ));
      },
    );
  }
}
