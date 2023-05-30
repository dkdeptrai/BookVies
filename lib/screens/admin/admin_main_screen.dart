import 'package:bookvies/blocs/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/admin/admin_analytics_screen/analytics_screen.dart';
import 'package:bookvies/screens/admin/admin_book_management_screen/admin_book_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const AnalyticsScreen(),
      const AdminBookManagementScreen(),
      const Placeholder(),
      const Placeholder(),
    ];
    final List<String> titles = ["Analytics", "Book", "Movie", "Report"];
    final List<String> icons = [
      AppAssets.icBook,
      AppAssets.icMovie,
      AppAssets.icLibrary,
      AppAssets.icMessage,
    ];

    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: screens,
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
