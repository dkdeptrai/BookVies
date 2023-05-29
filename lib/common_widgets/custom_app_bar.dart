import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget> actions;
  bool centerTitle;
  CustomAppBar(
      {super.key,
      required this.title,
      this.actions = const [],
      this.leading,
      this.centerTitle = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          (title != null) ? Text(title!, style: AppStyles.actionBarText) : null,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
    );
  }
}
