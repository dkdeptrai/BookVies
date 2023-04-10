import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
<<<<<<< HEAD
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
=======
>>>>>>> 19edae507f379b063920f87375ad4c52aed8ae9a
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NavBarBloc())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: "Poppins",
              primaryColor: Colors.red),
<<<<<<< HEAD
          home: const SignUpScreen()),
=======
          home: const MainScreen()),
>>>>>>> 19edae507f379b063920f87375ad4c52aed8ae9a
    );
  }
}
