import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  static const id = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 140, bottom: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: AppStyles.authenticationHeader,
                ),
                Column(
                  children: [
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
                    CustomTextFormField(
                      obscureText: _passwordObscured,
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.icPassword,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          AppAssets.icReveal,
                          height: 12,
                          width: 12,
                        ),
                        onPressed: () {
                          setState(
                              () => _passwordObscured = !_passwordObscured);
                        },
                      ),
                    ),
                    CustomTextFormField(
                      obscureText: _confirmPasswordObscured,
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.icPassword,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AppAssets.icReveal,
                            height: 12,
                            width: 12,
                          ),
                          onPressed: () {
                            setState(() => _confirmPasswordObscured =
                                !_confirmPasswordObscured);
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 23, bottom: 32),
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        onPressed: () {
                          //signup functionality
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: AppStyles.authenticateButtonTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Divider(
                            color: AppColors.greyTextColor,
                            thickness: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 22, right: 22),
                          child: Text(
                            "or",
                            style: AppStyles.hintTextStyle,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.greyTextColor,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 37),
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.greyTextColor)),
                      child: ElevatedButton(
                        onPressed: () {
                          //signup with Google functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 26,
                                left: 70,
                              ),
                              child: SvgPicture.asset(
                                AppAssets.icGoogle,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const Text(
                              'Sign up with Google',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already had an accout? ",
                          style: AppStyles.hintTextStyle),
                      GestureDetector(
                        onTap: _navigateToLoginScreen,
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6FE3E1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.id,
      (route) => false,
    );
  }
}
