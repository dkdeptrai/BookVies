import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/search_bar.dart';
import 'package:bookvies/models/chat_model.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/chat_list_screen/widget/chat_tile.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final Stream<List<Chat>> _chatStream;
  late BehaviorSubject<List<Chat>> _chatSubject;
  final searchController = TextEditingController();
  List<Chat> _filteredChat = [];

  @override
  void initState() {
    super.initState();
    final chatUpdatesResult = chatUpdates();
    _chatStream = chatUpdatesResult.item1;
    _chatSubject = chatUpdatesResult.item2;
  }

  @override
  void dispose() {
    _chatSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: CustomAppBar(
          title: 'Chat',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSearchBar(
                noBackButton: true,
                hint: 'Search for chat',
                onSearch: () => _chatSearch(searchController.text),
                controller: searchController,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Chat>>(
                stream: _chatStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            "Looks like you haven't chat with anyone yet!"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text(
                            "Looks like you haven't chat with anyone yet!"));
                  }
                  final chats =
                      _filteredChat.isNotEmpty ? _filteredChat : snapshot.data!;
                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ChatTile(
                        chat: chat,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _chatSearch(String text) async {
    if (text.isEmpty) {
      setState(() {
        _filteredChat = [];
      });
    } else {
      FocusScope.of(context).unfocus();
      final ref = await usersRef
          .where('keywords', arrayContains: searchController.text.toLowerCase())
          .limit(10)
          .get();
      var searchResults = ref.docs
          .map((doc) => UserModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
      var userIds = searchResults.map((user) => user.id).toList();
      setState(() {
        _filteredChat = _chatSubject.value
            .where((chat) => chat.usersId.any((id) => userIds.contains(id)))
            .toList();
      });
    }
  }
}

Tuple2<Stream<List<Chat>>, BehaviorSubject<List<Chat>>> chatUpdates() {
  final collectionStream = chatRef
      .where('usersId', arrayContains: firebaseAuth.currentUser!.uid)
      .orderBy('lastTime', descending: true)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .map((docSnapshot) => Chat.fromMap(
              docSnapshot.data()! as Map<String, dynamic>, docSnapshot.id))
          .toList());

  final chatSubject = BehaviorSubject<List<Chat>>.seeded([]);

  collectionStream.listen((chats) {
    for (var chat in chats) {
      chatRef
          .where('id', isEqualTo: chat.id)
          .snapshots()
          .listen((querySnapshot) {
        final updatedChat = querySnapshot.docs
            .map((docSnapshot) => Chat.fromMap(
                docSnapshot.data()! as Map<String, dynamic>, docSnapshot.id))
            .first;
        final chatIndex = chats.indexWhere((c) => c.id == updatedChat.id);
        if (chatIndex != -1) {
          chats[chatIndex] = updatedChat;
        }
        if (!chatSubject.isClosed) {
          chatSubject.add(chats);
        }
      });
    }
  });

  return Tuple2(chatSubject.stream.asBroadcastStream(), chatSubject);
}
