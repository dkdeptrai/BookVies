import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/models/book_model.dart';
import 'package:bookvies/screens/search_books_screen/widgets/search_book_item_widget.dart';
import 'package:bookvies/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchBooksScreen extends StatefulWidget {
  const SearchBooksScreen({super.key});

  static const id = "/search-books-screen";

  @override
  State<SearchBooksScreen> createState() => _SearchBooksScreenState();
}

class _SearchBooksScreenState extends State<SearchBooksScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Book> searchResult = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(
              hint: "Search books, authors, ISBN...",
              onSearch: onSearch,
              controller: searchController,
            ),
            isLoading
                ? Expanded(
                    child: Center(
                        child: SpinKitFadingCircle(
                      color: AppColors.mediumBlue,
                    )),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: searchResult.length,
                        itemBuilder: (context, index) {
                          return SearchBookItemWidget(
                              book: searchResult[index]);
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> onSearch() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });
    List<Book> newResult = await BookService()
        .searchBooks(keyword: searchController.text, limit: 10);

    setState(() {
      searchResult = newResult;
      isLoading = false;
    });
  }
}
