import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case (SignUpScreen.id):
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case (LoginScreen.id):
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
