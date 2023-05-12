import 'package:flutter/material.dart';

import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.height = 52,
    this.maxLines = 1,
    this.prefixIconConstraints,
    this.errorText,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  late final bool obscureText;
  late final double height;
  late final int? maxLines;
  late final BoxConstraints? prefixIconConstraints;
  String? errorText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var showError = widget.errorText == null ? false : true;

    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      height: widget.height + 20,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppStyles.primaryShadow],
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          SizedBox(
            height: widget.height,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: widget.maxLines,
              obscureText: widget.obscureText,
              controller: widget.controller,
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hintText,
                hintStyle: AppStyles.hintTextStyle,
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: widget.prefixIconConstraints,
                suffixIcon: widget.suffixIcon,
                focusedBorder: AppStyles.authenticateFieldBorder,
                enabledBorder: AppStyles.authenticateFieldBorder,
                border: AppStyles.authenticateFieldBorder,
                fillColor: AppColors.primaryBackgroundColor,
                filled: true,
              ),
            ),
          ),
          showError
              ? Positioned(
                  bottom: -3,
                  left: 10,
                  child: Text(
                    widget.errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 4),
                ),
        ],
      ),
    );
  }
}
