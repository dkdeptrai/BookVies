import 'package:bookvies/blocs/admin_newest_books_bloc/admin_newest_books_bloc.dart';
import 'package:bookvies/common_widgets/search_bar.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/extensions/string_extensions.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/admin/admin_book_management_screen/admin_media_widget.dart';
import 'package:bookvies/screens/admin/edit_book_screen/edit_book_screen.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSearchBookScreen extends StatefulWidget {
  const AdminSearchBookScreen({super.key});

  static const String id = "/admin-search-book-screen";

  @override
  State<AdminSearchBookScreen> createState() => _AdminSearchBookScreenState();
}

class _AdminSearchBookScreenState extends State<AdminSearchBookScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Book> searchResult = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        CustomSearchBar(
            controller: searchController,
            hint: "Search book",
            onSearch: () {
              searchResult.clear();
              FocusScope.of(context).unfocus();
              _searchBook();
            }),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final Book book = searchResult[index];
                return AdminMediaWidget(
                  media: book,
                  mediaType: MediaType.book.name,
                  onEdit: () => _navigateToEditBookScreen(book: book),
                  onDelete: () => _deleteBook(book: book),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(height: 15),
              itemCount: searchResult.length),
        )
      ]),
    ));
  }

  _searchBook() async {
    List<Book> newResult = [];

    newResult = await BookService().searchBooks(
        keyword: searchController.text.capitalizeFirstLetter(), limit: 20);

    setState(() {
      searchResult.addAll(newResult);
    });
  }

  _navigateToEditBookScreen({required Book book}) {
    Navigator.pushNamed(context, AdminEditBookScreen.id, arguments: book);
  }

  _deleteBook({required Book book}) {
    context
        .read<AdminNewestBooksBloc>()
        .add(DeleteBook(bookId: book.id, context: context));
    setState(() {
      searchResult.remove(book);
    });
  }
}
