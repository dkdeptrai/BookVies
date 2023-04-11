import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      height: 52,
      width: double.infinity,
      decoration: AppStyles.primaryBoxDecoration,
      child: TextFormField(
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText,
          hintStyle: AppStyles.hintTextStyle,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabledBorder: AppStyles.authenticateFieldBorder,
          focusedBorder: AppStyles.authenticateFieldBorder,
        ),
      ),
    );
  }
}
