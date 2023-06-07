import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, required this.userId});
  final String userId;
  Future<UserModel> _fetchUser() async {
    final document = usersRef.doc(userId);
    return UserModel.fromMap(
        (await document.get()).data() as Map<String, dynamic>);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Container();
        }
        final user = snapshot.data as UserModel;
        return Material(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            title: Text(user.name),
          ),
        );
      },
    );
  }
}
