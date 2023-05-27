import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = '/edit_profile_screen';
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  void _editUserInfo() {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      context.read<AuthBloc>().add(AuthEventEditUserInformation(
          name: _nameController.text,
          description: _descriptionController.text));
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _descriptionController.text = widget.user.description;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double topMargin = size.height * 0.05;
    final double bottomMargin = size.height * 0.03;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Edit Profile',
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.primaryTextColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.secondaryColor,
            height: size.height,
            margin: EdgeInsets.only(
                left: 20, right: 20, top: topMargin, bottom: bottomMargin),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  Image(
                    image: Image.asset(AppAssets.imgEditProfile).image,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 33, top: 6),
                    child: const Text(
                      "We need some personal information to create your own profile.",
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
                    keyboardType: TextInputType.multiline,
                    controller: _descriptionController,
                    hintText: "Your description",
                    prefixIconConstraints:
                        BoxConstraints.tight(const Size(24, 24)),
                    prefixIcon: const SizedBox(),
                    height: 166,
                    maxLines: null,
                  ),
                  CustomButtonWithGradientBackground(
                    height: 52,
                    text: "Submit",
                    onPressed: () {
                      _editUserInfo();
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
