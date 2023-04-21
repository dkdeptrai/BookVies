import 'package:flutter/material.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthEventSignUp(this.email, this.password, this.confirmPassword);
}

class AuthEventForgotPasswordSent extends AuthEvent {
  final String email;

  const AuthEventForgotPasswordSent(this.email);
}

class AuthEventForgotPassword extends AuthEvent {
  const AuthEventForgotPassword();
}
