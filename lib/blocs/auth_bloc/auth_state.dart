// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart' show immutable;

import 'package:bookvies/services/authentication/authentication_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(
    this.user,
  );
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });
}

class AuthStateSignUp extends AuthState {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthStateSignUp(
    this.email,
    this.password,
    this.confirmPassword,
  );
}

class AuthStateSignUpSuccess extends AuthState {
  const AuthStateSignUpSuccess();
}

class AuthStateSignUpFailure extends AuthState {
  final Exception exception;

  const AuthStateSignUpFailure(
    this.exception,
  );
}

class AuthStateForgotPassword extends AuthState {
  const AuthStateForgotPassword();
}

class AuthEventForgotPasswordFailure extends AuthState {
  final Exception exception;
  const AuthEventForgotPasswordFailure(this.exception);
}
