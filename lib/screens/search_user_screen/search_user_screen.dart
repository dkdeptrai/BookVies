import 'package:bookvies/common_widgets/search_bar.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/screens/profile_screen/profile_screen.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constant/colors.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});
  static const id = "/search-user-screen";

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController searchController = TextEditingController();
  List<UserModel> searchResult = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search for other users',
              onSearch: _onSearch,
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
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ProfileScreen.id,
                            arguments: searchResult[index].id),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(searchResult[index].imageUrl),
                          ),
                          title: Text(searchResult[index].name),
                        ),
                      );
                    },
                  ))
          ],
        ),
      ),
    );
  }

  void _onSearch() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final ref = await usersRef
        .where('keywords', arrayContains: searchController.text.toLowerCase())
        .limit(10)
        .get();

    setState(() {
      isLoading = false;
      searchResult = ref.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
    print(searchResult);
  }
}
