import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/books_screen/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screen = [
    const BookScreen(),
<<<<<<< Updated upstream
    const Placeholder(), // Replace with movies screen
    const Placeholder(), // Replace with library screen
    const Placeholder(), // Replace with chat screen
    const Placeholder() // Replace with profile screen
=======
    const MoviesScreen(),
    const LibraryScreen(),
    const ChatScreen(),
    const Placeholder()
>>>>>>> Stashed changes
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
                tabs: [
                  GButton(
                    iconActiveColor: Colors.red,
                    iconColor: Colors.blue,
                    icon: Icons.home,
                    leading: SvgPicture.asset(
                      AppAssets.icBook,
                      height: 24,
                      width: 24,
                      colorFilter: colorFilter(state.currentIndex == 0),
                    ),
                    text: "Books",
                  ),
                  GButton(
                    icon: Icons.home,
                    leading: SvgPicture.asset(
                      AppAssets.icMovie,
                      height: 24,
                      width: 24,
                      colorFilter: colorFilter(state.currentIndex == 1),
                    ),
                    text: "Movies",
                  ),
                  GButton(
                    icon: Icons.home,
                    leading: SvgPicture.asset(
                      AppAssets.icLibrary,
                      height: 24,
                      width: 24,
                      colorFilter: colorFilter(state.currentIndex == 2),
                    ),
                    text: "Library",
                  ),
                  GButton(
                    icon: Icons.home,
                    leading: SvgPicture.asset(
                      AppAssets.icMessage,
                      height: 24,
                      width: 24,
                      colorFilter: colorFilter(state.currentIndex == 3),
                    ),
                    text: "Chat",
                  ),
                  GButton(
                    icon: Icons.home,
                    leading: SvgPicture.asset(
                      AppAssets.icMovie,
                      height: 24,
                      width: 24,
                      colorFilter: colorFilter(state.currentIndex == 4),
                    ),
                    text: "Profile",
                  ),
                ]),
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
