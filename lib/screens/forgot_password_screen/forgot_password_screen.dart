import 'package:bookvies/common_widgets/custom_app_bar.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/forgot_password_screen/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const id = '/forgot-password-screen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  void sendEmailAndAlert() {}
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: "Forgot Password",
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppAssets.icArrowLeft)),
          ),
        ),
        body: Container(
          height: size.height,
          padding: EdgeInsets.only(
            top: size.height * 0.15,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              SvgPicture.asset(AppAssets.imgForgotPassword),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: const Text(
                  "Enter your registered email, we will send you a password reset email",
                  style: AppStyles.subHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: "Email",
                prefixIcon: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: SvgPicture.asset(
                    AppAssets.icEmail,
                    height: 14,
                    width: 14,
                  ),
                ),
              ),
              const Spacer(),
              CustomButtonWithGradientBackground(
                margin: const EdgeInsets.only(bottom: 27),
                height: 54,
                text: "Send",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NotiDiaglog();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
