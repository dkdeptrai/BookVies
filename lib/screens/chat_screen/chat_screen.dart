// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/screens/chat_screen/widgets/chat_messages_widget.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: CustomAppBar(
          centerTitle: false,
          title: 'ChatUser',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
      ),
      body: Container(
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: ChatMessagesWidget(
                chat: widget.chat,
                shrinkWrap: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: CustomTextFormField(
                controller: messageController,
                maxLines: 3,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(AppAssets.icSend),
                  onPressed: () async =>
                      await _sendMessage(messageController.text),
                ),
                hintText: 'Type your message here...',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty) return;
    final batch = FirebaseFirestore.instance.batch();

    final chatDocRef =
        FirebaseFirestore.instance.collection('chat').doc(widget.chat.docId);
    final messagesCollRef = chatDocRef.collection('messages');

    batch.set(
      messagesCollRef.doc(),
      {
        'content': text,
        'sendTime': DateTime.now(),
        'senderId': currentUser!.uid,
      },
    );

    batch.update(
      chatDocRef,
      {
        'lastMessage': text,
        'lastTime': DateTime.now(),
      },
    );
    setState(() {
      messageController.clear();
    });
    await batch.commit();
  }
}
