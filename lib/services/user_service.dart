import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';

class UserService {
  Future<UserModel?> loadUserData() async {
    try {
      final String uid = firebaseAuth.currentUser!.uid;
<<<<<<< HEAD
=======
      print("Uid: $uid");
>>>>>>> c5aa9b67c4a782b7195c2dda096bd546bfaf6062

      final snapshot = await usersRef.doc(uid).get();

      return UserModel.fromMap(snapshot.data() as Map<String, dynamic>)
          .copyWith(id: snapshot.id);
    } catch (error) {
      print("Load user error: $error");
      return null;
    }
  }
}
