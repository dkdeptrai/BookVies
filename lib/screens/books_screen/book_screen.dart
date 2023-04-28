import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/screens/books_screen/widgets/explore_books_widget.dart';
import 'package:bookvies/screens/books_screen/widgets/highest_rating_book_widget.dart';
import 'package:bookvies/screens/books_screen/widgets/popular_books_widget.dart';
import 'package:bookvies/screens/search_books_screen/search_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: CustomAppBar(
            title: "Books",
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  //_navigateToSearchBooksScreen(context),
                  icon: SvgPicture.asset(AppAssets.icSearch))
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HighestRatingBookWidget(),
              PopularBookWidget(margin: EdgeInsets.only(top: 5)),
              ExploreBooksWidget()
            ],
          ),
        ),
      ),
    );
  }

  _navigateToSearchBooksScreen(BuildContext context) {
    Navigator.pushNamed(context, SearchBooksScreen.id);
  }
}
