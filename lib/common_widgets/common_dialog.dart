import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  final String message;
  final Widget icon;
  const CommonDialog({super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: SizedBox(height: 80, width: 80, child: icon),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK")),
      ],
    );
  }
}
