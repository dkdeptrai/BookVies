import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<Widget> actions;
  const CustomAppBar({super.key, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Books", style: AppStyles.actionBarText),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: actions,
    );
  }
}
