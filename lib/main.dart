import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/blocs/description_review_list_bloc/description_review_list_bloc.dart';
import 'package:bookvies/blocs/reading_goal_bloc/reading_goal_bloc.dart';
import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/blocs/watching_goal_bloc/watching_goal_bloc.dart';
import 'package:bookvies/screens/favorite_genres_screen/favorite_genres_screen.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:bookvies/screens/personal_information_screen/personal_information_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/screens/splash_screen/splash_screen.dart';
import 'package:bookvies/services/authentication/authentication_firebase_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bookvies/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => UserBloc()),
      BlocProvider(create: (_) => NavBarBloc()),
      BlocProvider(create: (_) => DescriptionReviewListBloc()),
      BlocProvider(create: (_) => AuthBloc(FirebaseAuthProvider())),
      BlocProvider(create: (_) => ReadingGoalBloc()),
      BlocProvider(create: (_) => WatchingGoalBloc()),
    ],
    child: MyApp(appRouter: AppRouter()),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

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
          // return ProfileScreen(userId: currentUser!.uid);
          if (state is AuthStateLoggedIn) {
            context.read<UserBloc>().add(const LoadUser());
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return const MainScreen();
                } else if (state is UserLoading) {
                  return const SplashScreen();
                } else if (state is UserLoadFailed) {
                  return Scaffold(
                    body: Center(child: Text(state.message)),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else if (state is AuthStateLoggedOut) {
            return const LoginScreen();
          } else if (state is AuthStateSignUpFailure) {
            return const SignUpScreen();
          } else if (state is AuthStateForgotPassword) {
            return const ForgotPasswordScreen();
          } else if (state is AuthStateNeedSignUp) {
            return const SignUpScreen();
          } else if (state is AuthStateNoUserInformation) {
            return const PersonalInformationScreen();
          } else if (state is AuthStateNoFavoritesGenres) {
            return const FavoriteGenresScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  state.toString(),
                ),
              ),
            );
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
