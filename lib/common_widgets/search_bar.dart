import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final VoidCallback onSearch;
  const SearchBar(
      {super.key, required this.hint, this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                  borderSide: const BorderSide(color: AppColors.greyTextColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: AppColors.greyTextColor),
                )),
          ),
        )),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //   child: SvgPicture.asset(AppAssets.icSearch),
        // )
        IconButton(
            onPressed: onSearch, icon: SvgPicture.asset(AppAssets.icSearch))
      ],
    );
  }
}
