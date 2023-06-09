import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class UserService {
  Future<UserModel?> loadUserData() async {
    try {
      final String uid = firebaseAuth.currentUser!.uid;
      print("loadUser uid: $uid");
      final snapshot = await usersRef.doc(uid).get();

      return UserModel.fromMap(snapshot.data() as Map<String, dynamic>)
          .copyWith(id: snapshot.id);
    } catch (error) {
      return null;
    }
  }
}
