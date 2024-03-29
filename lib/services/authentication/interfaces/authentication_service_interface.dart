import 'package:bookvies/services/authentication/authentication_user.dart';

abstract class IAuthenticationService {
  AuthUser? get currentUser;

  Future<void> initialize();
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendPasswordResetEmail({required String email});
  Future<AuthUser> signInWithGoogle();
}
