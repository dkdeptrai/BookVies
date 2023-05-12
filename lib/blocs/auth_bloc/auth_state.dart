import 'dart:io';

import 'package:bookvies/models/user_model.dart';
import 'package:equatable/equatable.dart';
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

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
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

class AuthStateNeedSignUp extends AuthState {
  const AuthStateNeedSignUp();
}

class AuthStateForgotPassword extends AuthState {
  const AuthStateForgotPassword();
}

class AuthStateForgotPasswordFailure extends AuthState {
  final Exception exception;
  const AuthStateForgotPasswordFailure(this.exception);
}

class AuthStateNoUserInformation extends AuthState {
  const AuthStateNoUserInformation();
}

class AuthStateUserInformation extends AuthState {
  final File image;
  final String name;
  final String description;

  const AuthStateUserInformation(
    this.image,
    this.name,
    this.description,
  );
}
