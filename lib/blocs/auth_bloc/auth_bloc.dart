import 'package:bloc/bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/services/authentication/authentication_exceptions.dart';
import 'package:bookvies/services/authentication/authentication_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user != null) {
        emit(AuthStateLoggedIn(user));
      } else {
        emit(const AuthStateLoggedOut(null));
      }
    });
    on<AuthEventLogin>(
      (event, emit) async {
        try {
          final user = await provider.logIn(
              email: event.email, password: event.password);
          emit(AuthStateLoggedIn(user));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(e));
        }
      },
    );
    on<AuthEventLogOut>((event, emit) async {
      try {
        if (provider.currentUser != null) {
          await provider.logOut();
        }
        emit(const AuthStateLoggedOut(null));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e));
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
        emit(const AuthStateSignUpSuccess());
      } on Exception catch (e) {
        emit(AuthStateSignUpFailure(e));
      }
    });
    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword());
    });
    on<AuthEventForgotPasswordSent>((event, emit) async {
      try {
        await provider.sendPasswordResetEmail(email: event.email);
        emit(const AuthStateLoggedOut(null));
      } on Exception catch (e) {
        emit(AuthEventForgotPasswordFailure(e));
      }
    });
  }
}
