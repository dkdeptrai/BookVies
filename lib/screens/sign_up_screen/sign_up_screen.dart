import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
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
    var center = Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                AppStyles.primaryShadow,
              ],
            ),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: emailController,
              decoration: InputDecoration(
                fillColor: AppColors.secondaryColor,
                hintText: 'Email',
                hintStyle: AppStyles.hintTextStyle,
                prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: SvgPicture.asset(AppAssets.icEmail)),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: AppStyles.authenticateFieldBorder,
                focusedBorder: AppStyles.authenticateFieldBorder,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                AppStyles.primaryShadow,
              ],
            ),
            child: TextFormField(
              obscureText: _passwordObscured,
              textAlignVertical: TextAlignVertical.center,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: AppStyles.hintTextStyle,
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
                    setState(() {
                      _passwordObscured = !_passwordObscured;
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: AppStyles.authenticateFieldBorder,
                focusedBorder: AppStyles.authenticateFieldBorder,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 14),
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                AppStyles.primaryShadow,
              ],
            ),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: _confirmPasswordObscured,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: AppStyles.hintTextStyle,
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
                    setState(() {
                      _confirmPasswordObscured = !_confirmPasswordObscured;
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: AppStyles.authenticateFieldBorder,
                focusedBorder: AppStyles.authenticateFieldBorder,
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
              onPressed: () {},
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
              onPressed: () {},
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
    );
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 140, bottom: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign up',
                style: AppStyles.authenticationHeader,
              ),
              center,
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You don't have an account?",
                      style: AppStyles.hintTextStyle),
                  GestureDetector(
                    onTap: () {
                      // navigate to sign in
                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
