// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/screens/chat_screen/widgets/messages_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/message_model.dart';
import 'package:rxdart/rxdart.dart';

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
  final BehaviorSubject<List<Message>> _messagesSubject =
      BehaviorSubject<List<Message>>.seeded([]);
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.chat.docId)
        .collection('messages')
        .orderBy('sendTime', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList())
        .listen((messages) {
      if (mounted) {
        setState(() {
          _messagesSubject.add([...messages, ..._messagesSubject.value]);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messagesSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: _messagesSubject.stream,
      initialData: const [],
      // stream: _getChatDocumentStream(widget.chat.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error: \${snapshot.error}');
        }

        var messages = snapshot.data!;
        // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        return ListView.builder(
          reverse: true,
          controller: _scrollController,
          itemCount: messages.length,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
  }
}
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   Stream<QueryDocumentSnapshot> _getChatDocumentStream(String chatId) {
//     return FirebaseFirestore.instance
//         .collection('chat')
//         .where('id', isEqualTo: chatId)
//         .orderBy('lastTime', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.first);
//   }
// }
