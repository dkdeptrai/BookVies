// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/screens/chat_screen/widgets/messages_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/message_model.dart';

class ChatMessagesWidget extends StatefulWidget {
  final Chat chat;
  final bool shrinkWrap;
  const ChatMessagesWidget({
    Key? key,
    required this.chat,
    required this.shrinkWrap,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatMessagesWidgetState createState() => _ChatMessagesWidgetState();
}

class _ChatMessagesWidgetState extends State<ChatMessagesWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QueryDocumentSnapshot>(
      stream: _getChatDocumentStream(widget.chat.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error: \${snapshot.error}');
        }

        final chatDocument = snapshot.data;
        if (chatDocument != null) {
          return StreamBuilder<List<Message>>(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .doc(chatDocument.id)
                .collection('messages')
                .orderBy('sendTime', descending: true)
                .snapshots()
                .map((snapshot) => snapshot.docs
                    .map((doc) => Message.fromMap(doc.data()))
                    .toList()),
            builder: (context, messageSnapshot) {
              if (messageSnapshot.hasError) {
                return const Text('Error: \${messageSnapshot.error}');
              }

              if (messageSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var messages = messageSnapshot.data!;
              messages = messages.reversed.toList();
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _scrollToBottom());
              return ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: widget.shrinkWrap,
                itemBuilder: (context, index) {
                  bool showSendTime = index == 0 ||
                      messages[index]
                              .sendTime
                              .difference(messages[index - 1].sendTime)
                              .inMinutes >
                          5;
                  return MessageWidget(
                    message: messages[index],
                    showSendTime: showSendTime,
                  );
                },
              );
            },
          );
        } else {
          return const Text('No chat found with the given ID');
        }
      },
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  Stream<QueryDocumentSnapshot> _getChatDocumentStream(String chatId) {
    return FirebaseFirestore.instance
        .collection('chat')
        .where('id', isEqualTo: chatId)
        .orderBy('lastTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }
}
