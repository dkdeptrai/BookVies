import 'dart:io';

import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInformationScreen extends StatefulWidget {
  static const id = '/personal-information-screen';
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? _pickedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double topMargin = size.height * 0.05;
    final double bottomMargin = size.height * 0.03;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.only(
                left: 20, right: 20, top: topMargin, bottom: bottomMargin),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  width: double.infinity,
                  child: const Text(
                    "Personal information",
                    style: AppStyles.authenticationHeader,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 33, top: 6),
                  child: const Text(
                    "We need some personal information to create your own profile.",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 33, bottom: 10),
                  width: double.infinity,
                  child: const Text(
                    "Choose your profile image",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _pickedImage == null
                          ? SvgPicture.asset(
                              AppAssets.icUser,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _pickedImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 3),
                  width: double.infinity,
                  child: const Text(
                    "Your name",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: "Name",
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(24, 24)),
                  prefixIcon: const SizedBox(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 3),
                  width: double.infinity,
                  child: const Text(
                    "Your description",
                    style: AppStyles.subHeaderTextStyle,
                  ),
                ),
                CustomTextFormField(
                  controller: _descriptionController,
                  hintText: "Your description",
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(24, 24)),
                  prefixIcon: const SizedBox(),
                  height: 166,
                  maxLines: null,
                ),
                const Spacer(),
                CustomButtonWithGradientBackground(
                  height: 52,
                  text: "Submit",
                  margin: EdgeInsets.only(bottom: bottomMargin),
                  onPressed: () {
                    _uploadUserInfo();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedFile.path);
    });
  }

  Future<void> _uploadUserInfo() async {
    if (_pickedImage == null ||
        _nameController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      return;
    }
    context.read<AuthBloc>().add(AuthEventAddUserInformation(
          name: _nameController.text,
          description: _descriptionController.text,
          image: _pickedImage!,
        ));
  }
}
