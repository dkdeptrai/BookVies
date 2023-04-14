import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bookvies/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NavBarBloc())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.onGenerateRoute,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: "Poppins",
              primaryColor: Colors.red),
          home: const SignUpScreen()),
    );
  }
}
