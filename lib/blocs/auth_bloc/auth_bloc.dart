import 'package:bloc/bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/services/authentication/authentication_exceptions.dart';
import 'package:bookvies/services/authentication/authentication_firebase_provider.dart';
import 'package:bookvies/services/authentication/authentication_provider.dart';
import 'package:bookvies/services/authentication/authentication_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../screens/forgot_password_screen/widgets/noti_dialog.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user != null) {
        var docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (docSnapshot.exists) {
          emit(AuthStateLoggedIn(user));
        } else {
          emit(const AuthStateNoUserInformation());
        }
      } else {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      }
    });
    on<AuthEventLogin>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: true,
          ),
        );
        try {
          final user = await provider.logIn(
              email: event.email, password: event.password);
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          DocumentSnapshot? userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          if (userData.exists) {
            emit(AuthStateLoggedIn(user));
          } else {
            emit(const AuthStateNoUserInformation());
          }
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
    on<AuthEventSignInWithGoogle>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
        ),
      );
      try {
        final user = await provider.signInWithGoogle();
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      try {
        if (provider.currentUser != null) {
          await provider.logOut();
        }
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
    on<AuthEventSignUp>((event, emit) async {
      try {
        if (event.password != event.confirmPassword) {
          throw PasswordAndConfirmPasswordNotMatchAuthException();
        }
        await provider.createUser(
          email: event.email,
          password: event.password,
        );
      } on Exception catch (e) {
        emit(AuthStateSignUpFailure(e));
        return;
      }
      try {
        await provider.logIn(email: event.email, password: event.password);
        emit(const AuthStateNoUserInformation());
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });

    on<AuthEventNeedSignUp>((event, emit) async {
      emit(const AuthStateNeedSignUp());
    });

    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword());
    });
    on<AuthEventForgotPasswordSent>((event, emit) async {
      try {
        await provider.sendPasswordResetEmail(email: event.email);
        // ignore: use_build_context_synchronously
        showDialog(
          context: event.context,
          builder: (context) => NotiDialog(),
          barrierDismissible: true,
        );
        emit(state);
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
    on<AuthEventAddUserInformation>(
      (event, emit) async {
        AuthUser? user = FirebaseAuthProvider().currentUser;

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("user_images").child(user!.uid);
        UploadTask uploadTask = ref.putFile(event.image);

        await uploadTask.whenComplete(() async {
          // Get the image URL
          String imageUrl = await ref.getDownloadURL();

          // Check if the document exists
          var docSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (docSnapshot.exists) {
            // Update the existing document
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({
              'imageUrl': imageUrl,
              'name': event.name,
              'description': event.description,
            });
          } else {
            // Create a new document
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'imageUrl': imageUrl,
              'name': event.name,
              'description': event.description,
              'uid': user.uid,
              'favoriteGenres': [],
            });
          }
        });

        emit(const AuthStateNoFavoritesGenres());
      },
    );
    on<AuthEventAddUserFavoriteGenres>(
      (event, emit) async {
        AuthUser? user = FirebaseAuthProvider().currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'favoriteGenres': event.genres,
        });
        emit(AuthStateLoggedIn(user));
      },
    );
  }
}
