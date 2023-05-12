import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/books_screen/book_screen.dart';
import 'package:bookvies/screens/chat_screen/chat_screen.dart';
import 'package:bookvies/screens/library_screen/library_screen.dart';
import 'package:bookvies/screens/movies_screen/movies_screen.dart';
import 'package:bookvies/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const id = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screen = [
    const BookScreen(),
    const MoviesScreen(),
    const LibraryScreen(),
    const ChatScreen(),
    const ProfileScreen()
  ];

  final List<String> titles = ["Books", "Movies", "Library", "Chat", "Profile"];

  final List<String> icons = [
    AppAssets.icBook,
    AppAssets.icMovie,
    AppAssets.icLibrary,
    AppAssets.icMessage,
    AppAssets.icProfile
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: screen,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: GNav(
                rippleColor: Colors.grey[800]!,
                hoverColor: Colors.grey[300]!,
                haptic: true,
                tabBorderRadius: 15,
                tabBackgroundGradient: AppColors.primaryGradient,
                gap: 8,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                onTabChange: (newIndex) {
                  context
                      .read<NavBarBloc>()
                      .add(UpdateIndex(newIndex: newIndex));
                },
                tabs: List.generate(
                    titles.length,
                    (index) => GButton(
                          iconActiveColor: Colors.red,
                          iconColor: Colors.blue,
                          icon: Icons.home,
                          leading: SvgPicture.asset(
                            icons[index],
                            height: 24,
                            width: 24,
                            colorFilter:
                                colorFilter(state.currentIndex == index),
                          ),
                          text: titles[index],
                        ))),
          ),
        );
      },
    );
  }

  ColorFilter colorFilter(bool isActive) {
    return ColorFilter.mode(
        isActive ? AppColors.navBarActiveColor : AppColors.navBarInactiveColor,
        BlendMode.srcIn);
  }
}
