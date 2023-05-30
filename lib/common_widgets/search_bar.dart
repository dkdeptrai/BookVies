import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final VoidCallback onSearch;
  final bool noBackButton;
  final EdgeInsets? margin;
  const CustomSearchBar(
      {super.key,
      required this.hint,
      this.controller,
      required this.onSearch,
      this.noBackButton = false,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          if (!noBackButton)
            IconButton(
                onPressed: () => Navigator.pop(context),
                // iconSize: 50,
                icon: SvgPicture.asset(AppAssets.icArrowLeft)),
          Expanded(
              child: SizedBox(
            height: 35,
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: AppStyles.searchBoxText,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        const BorderSide(color: AppColors.greyTextColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide:
                        const BorderSide(color: AppColors.greyTextColor),
                  )),
              onFieldSubmitted: (keyword) {
                FocusScope.of(context).unfocus();
                onSearch();
              },
            ),
          )),
          IconButton(
              onPressed: onSearch, icon: SvgPicture.asset(AppAssets.icSearch))
        ],
      ),
    );
  }
}
