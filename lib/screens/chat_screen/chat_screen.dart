import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: CustomAppBar(
            centerTitle: false,
            title: 'ChatUser',
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(children: [
              _buildListOfMessage(),
              _buildInput(),
              _buildLoading(),
            ])
          ],
        ));
  }

  _buildListOfMessage() {}

  _buildInput() {}

  _buildLoading() {}
}
