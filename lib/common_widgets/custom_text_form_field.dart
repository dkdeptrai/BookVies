// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';

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
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  late final bool obscureText;
  late final double height;
  late final int? maxLines;
  late final BoxConstraints? prefixIconConstraints;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      height: widget.height,
      width: double.infinity,
      decoration: AppStyles.primaryBoxDecoration,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppStyles.hintTextStyle,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: widget.prefixIconConstraints,
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
