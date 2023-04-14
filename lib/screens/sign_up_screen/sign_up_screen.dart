import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:bookvies/services/authentication/authentication_exceptions.dart';
import 'package:bookvies/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  static const id = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;

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
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.icEmail,
                          height: 14,
                          width: 14,
                        ),
                      ),
                      errorText: _emailErrorText,
                    ),
                    CustomTextFormField(
                      obscureText: _passwordObscured,
                      controller: _passwordController,
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
                      errorText: _passwordErrorText,
                    ),
                    CustomTextFormField(
                      obscureText: _confirmPasswordObscured,
                      controller: _confirmPasswordController,
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
                      errorText: _confirmPasswordErrorText,
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
                          _registerNewUser();
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

  Future<void> _registerNewUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    if (email == "") {
      setState(() {
        _emailErrorText = "Email is required";
        _passwordErrorText = _confirmPasswordErrorText = null;
      });
      return;
    }
    if (password == "") {
      setState(() {
        _passwordErrorText = "Password is required";
        _emailErrorText = _confirmPasswordErrorText = null;
      });
      return;
    }

    if (confirmPassword == "") {
      setState(() {
        _confirmPasswordErrorText = "Confirm password is required";
        _emailErrorText = _passwordErrorText = null;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _passwordErrorText =
            _confirmPasswordErrorText = "Passwords do not match";
        _emailErrorText = null;
      });
      return;
    }
    try {
      await AuthService.firebase().createUser(
        email: email,
        password: password,
      );
    } on WeakPasswordAuthException {
      setState(() {
        _emailErrorText = null;
        _passwordErrorText = _confirmPasswordErrorText = "Password is too weak";
      });
    } on EmailAlreadyInUseAuthException {
      setState(() {
        _emailErrorText = "Email is already in use";
        _passwordErrorText = _confirmPasswordErrorText = null;
      });
    } on InvalidEmailAuthException {
      setState(() {
        _emailErrorText = "Email is invalid";
        _passwordErrorText = _confirmPasswordErrorText = null;
      });
    } on GenericAuthException {
      setState(() {
        _emailErrorText = "Something went wrong";
        _passwordErrorText = _confirmPasswordErrorText = null;
      });
    }
  }
}
