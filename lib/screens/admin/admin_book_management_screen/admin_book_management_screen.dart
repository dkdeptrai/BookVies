import 'package:bookvies/blocs/admin_newest_books_bloc/admin_newest_books_bloc.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/gradient_text.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/admin/add_book_screen/admin_add_book_screen.dart';
import 'package:bookvies/screens/admin/admin_book_management_screen/newest_book_widget.dart';
import 'package:bookvies/screens/admin/admin_search_book_screen/admin_search_book_screen.dart';
import 'package:bookvies/screens/admin/edit_book_screen/edit_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminBookManagementScreen extends StatefulWidget {
  const AdminBookManagementScreen({super.key});

  @override
  State<AdminBookManagementScreen> createState() =>
      _AdminBookManagementScreenState();
}

class _AdminBookManagementScreenState extends State<AdminBookManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminNewestBooksBloc>().add(LoadAdminNewestBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: AppDimensions.defaultAppBarPreferredSize,
          child: CustomAppBar(title: "Book management")),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 30),
                    decoration: BoxDecoration(
                        color: AppColors.lightBlueBackground,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Number of books",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkBlueBackground),
                          ),
                          const SizedBox(height: 10),
                          const GradientText(
                              text: "60000",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                              gradient: AppColors.primaryGradient),
                        ]),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColors.lightGrey,
                      child: IconButton(
                          onPressed: _navigateToAddBookScreen,
                          icon: SvgPicture.asset(AppAssets.icPlus)),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: AppColors.lightGrey,
                      child: IconButton(
                          onPressed: _navigateToSearchScreen,
                          icon: SvgPicture.asset(AppAssets.icSearch)),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text("Newest books", style: AppStyles.adminHeader),
          BlocBuilder<AdminNewestBooksBloc, AdminNewestBooksState>(
            builder: (context, state) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final book = state.newestBooks[index];
                    return AdminNewestBookWidget(
                      book: book,
                      onEdit: () => _navigateToEditBookScreen(book: book),
                      onDelete: () => _deleteBook(bookId: book.id),
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(height: 15),
                  itemCount: state.newestBooks.length);
            },
          ),
          BlocBuilder<AdminNewestBooksBloc, AdminNewestBooksState>(
            builder: (context, state) {
              if (state is AdminNewestBooksLoading) {
                return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2));
              }
              return TextButton(
                onPressed: () {
                  context
                      .read<AdminNewestBooksBloc>()
                      .add(LoadAdminNewestBooks());
                },
                child: const Text("Load more"),
              );
            },
          )
        ]),
      ),
    );
  }

  _navigateToEditBookScreen({required Book book}) {
    Navigator.pushNamed(context, AdminEditBookScreen.id, arguments: book);
  }

  _deleteBook({required String bookId}) {
    context
        .read<AdminNewestBooksBloc>()
        .add(DeleteBook(bookId: bookId, context: context));
  }

  _navigateToAddBookScreen() {
    Navigator.pushNamed(context, AdminAddBookScreen.id);
  }

  _navigateToSearchScreen() {
    Navigator.pushNamed(context, AdminSearchBookScreen.id);
  }
}
