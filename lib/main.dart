import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/book_description_screen/description_screen.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:bookvies/screens/movies_screen/movies_screen.dart';
import 'package:bookvies/screens/personal_information_screen/personal_information_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/services/authentication/authentication_firebase_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bookvies/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/utils/router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => NavBarBloc()),
      BlocProvider(create: (_) => DescriptionReviewListBloc()),
      BlocProvider(create: (_) => AuthBloc(FirebaseAuthProvider())),
    ],
    child: MyApp(appRouter: AppRouter()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.onGenerateRoute,
      title: 'BookVies',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
          primaryColor: Colors.red),
      home:
          // MainScreen()

          BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print("User authentication state: $state");

          if (state is AuthStateLoggedIn) {
            return const MainScreen();
          } else if (state is AuthStateLoggedOut) {
            return const LoginScreen();
          } else if (state is AuthStateForgotPassword) {
            return const ForgotPasswordScreen();
          } else if (state is AuthStateNeedSignUp) {
            return const SignUpScreen();
          } else {
            return Scaffold(
              body: Center(
                child: SpinKitFadingCircle(color: AppColors.mediumBlue),
              ),
            );
          }
        },
      ),
    );
  }
}
