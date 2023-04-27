import 'package:flutter/material.dart' show BuildContext, immutable;

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

class AuthEventSignInWithGoogle extends AuthEvent {
  const AuthEventSignInWithGoogle();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventNeedSignUp extends AuthEvent {
  const AuthEventNeedSignUp();
}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const AuthEventSignUp(this.email, this.password, this.confirmPassword);
}

class AuthEventForgotPasswordSent extends AuthEvent {
  final String email;
  final BuildContext context;
  const AuthEventForgotPasswordSent(this.email, this.context);
}

class AuthEventForgotPassword extends AuthEvent {
  const AuthEventForgotPassword();
}
