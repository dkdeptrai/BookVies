import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  const CustomAppBar(
      {super.key, required this.title, this.actions = const [], this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppStyles.actionBarText),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: leading,
      actions: actions,
    );
  }
}
