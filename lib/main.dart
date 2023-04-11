import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/screens/main_screen/main_screen.dart';
import 'package:bookvies/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
          home: const MainScreen()),
    );
  }
}
