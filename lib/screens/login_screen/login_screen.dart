import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordObscured = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double topMargin = size.height * 0.174;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.only(
                left: 20, right: 20, top: topMargin, bottom: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
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
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.icPassword,
                          height: 14,
                          width: 14,
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
                      obscureText: _passwordObscured,
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
                          //login
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Login',
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
                          //login with google
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
                              'Sign in with Google',
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
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _navigateToForgotPasswordScreen();
                        },
                        child: const Text(
                          'Forgot password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6FE3E1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have an account? ",
                        style: AppStyles.hintTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigateToSignUpScreen();
                        },
                        child: const Text(
                          'Sign up',
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

  _navigateToSignUpScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignUpScreen.id,
      (route) => false,
    );
  }

  _navigateToForgotPasswordScreen() {
    Navigator.pushNamed(
      context,
      ForgotPasswordScreen.id,
    );
  }
}
