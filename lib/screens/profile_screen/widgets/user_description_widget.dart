import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/chat_screen/chat_screen.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDescriptionWidget extends StatefulWidget {
  final UserModel user;
  const UserDescriptionWidget({super.key, required this.user});

  @override
  State<UserDescriptionWidget> createState() => _UserDescriptionWidgetState();
}

class _UserDescriptionWidgetState extends State<UserDescriptionWidget> {
  late UserModel _currentUserModel;

  late bool _followed;
  @override
  void initState() {
    super.initState();
    final UserState userState = context.read<UserBloc>().state;
    if (userState is UserLoaded) {
      _currentUserModel = userState.user;
      _followed = _currentUserModel.following.contains(widget.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 254),
      child: Stack(
        children: [
          Positioned(
            top: 40, // Move the container down by 40
            left: 0,
            right: 0,
            child: Container(
              height: 214,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: AppColors.secondaryColor,
                boxShadow: [AppStyles.secondaryShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.name,
                      style: AppStyles.sectionHeaderText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                        widget.user.description,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: widget.user.id != firebaseAuth.currentUser!.uid
                          ? Row(
                              children: [
                                Expanded(
                                  child: _followed
                                      ? CustomButtonWithGradientBackground(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          height: 40,
                                          width: 247,
                                          text: 'Unfollow',
                                          onPressed: () => _unfollowUser(),
                                        )
                                      : CustomButtonWithGradientBackground(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          height: 40,
                                          width: 247,
                                          text: 'Follow',
                                          onPressed: () => _followUser(),
                                        ),
                                ),
                                IconButton(
                                    onPressed: () => _initiateChat(),
                                    icon: SvgPicture.asset(AppAssets.icSend))
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.user.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _followUser() async {
    final batch = FirebaseFirestore.instance.batch();
    batch.update(usersRef.doc(firebaseAuth.currentUser!.uid), {
      'following': FieldValue.arrayUnion([widget.user.id])
    });
    batch.update(usersRef.doc(widget.user.id), {
      'followers': FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
    });
    _currentUserModel.following.add(widget.user.id);
    widget.user.followers.add(firebaseAuth.currentUser!.uid);
    await batch.commit();
    if (mounted) {
      setState(() {
        _followed = true;
      });
    }
  }

  _unfollowUser() async {
    final batch = FirebaseFirestore.instance.batch();
    batch.update(usersRef.doc(firebaseAuth.currentUser!.uid), {
      'following': FieldValue.arrayRemove([widget.user.id])
    });
    batch.update(usersRef.doc(widget.user.id), {
      'followers': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid])
    });
    _currentUserModel.following.remove(widget.user.id);
    widget.user.followers.remove(firebaseAuth.currentUser!.uid);
    await batch.commit();
    if (mounted) {
      setState(() {
        _followed = false;
      });
    }
  }

  Future<void> _initiateChat() async {
    StringBuffer sb = StringBuffer();
    if (firebaseAuth.currentUser!.uid.compareTo(widget.user.id) < 0) {
      sb.write(firebaseAuth.currentUser!.uid);
      sb.write(widget.user.id);
    } else {
      sb.write(widget.user.id);
      sb.write(firebaseAuth.currentUser!.uid);
    }
    String chatId = sb.toString();
    String chatDocId = '';

    final chatDocRef = chatRef.where('id', isEqualTo: chatId);
    final chatDocSnapshot = await chatDocRef.get();

    if (chatDocSnapshot.size == 0) {
      final newChatDoc = await chatRef.add({
        'id': chatId,
        'lastMessage': '',
        'lastTime': DateTime.now(),
        'usersId': [firebaseAuth.currentUser!.uid, widget.user.id],
      });
      chatDocId = newChatDoc.id;
    } else {
      chatDocId = chatDocSnapshot.docs[0].id;
    }

    Chat chat = Chat(
      id: chatId,
      usersId: [firebaseAuth.currentUser!.uid, widget.user.id],
      lastTime: DateTime.now(),
      docId: chatDocId,
    );
    Navigator.pushNamed(context, ChatScreen.id, arguments: chat);
  }
}
