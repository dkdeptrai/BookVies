// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:bookvies/common_widgets/custom_app_bar.dart';
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
        child: FutureBuilder(
            future: _getUserName(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomAppBar(
                  centerTitle: false,
                  title: 'Loading...',
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                );
              } else {
                return CustomAppBar(
                  centerTitle: false,
                  title: snapshot.data as String,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                );
              }
            })),
      ),
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: ChatMessagesWidget(
                chat: widget.chat,
                shrinkWrap: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      minHeight: 52,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      textAlignVertical: TextAlignVertical.center,
                      minLines: 1,
                      maxLines: 5,
                      controller: messageController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Type your message here...',
                        hintStyle: AppStyles.hintTextStyle,
                        focusedBorder: AppStyles.authenticateFieldBorder,
                        enabledBorder: AppStyles.authenticateFieldBorder,
                        border: AppStyles.authenticateFieldBorder,
                        fillColor: AppColors.primaryBackgroundColor,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(AppAssets.icSend),
                  onPressed: () async =>
                      await _sendMessage(messageController.text),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> _getUserName() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.chat.usersId.where((id) => id != currentUser!.uid).first)
        .get()
        .then((value) => value.data()!['name']);
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty) return;
    text = text.trim();
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
