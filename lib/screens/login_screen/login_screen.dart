import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/blocs/auth_bloc/auth_state.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/common_widgets/custom_text_form_field.dart';
import 'package:bookvies/common_widgets/dialogs/loading_dialog.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:bookvies/screens/sign_up_screen/sign_up_screen.dart';
import 'package:bookvies/services/authentication/authentication_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailErrorText;
  String? _passwordErrorText;
  bool _passwordObscured = true;
  CloseDialog? _closeDialogHandle;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double topMargin = size.height * 0.174;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        _handleLoginExceptions(state);
      },
      child: Scaffold(
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
                        keyboardType: TextInputType.emailAddress,
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
                        controller: _passwordController,
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
                        errorText: _passwordErrorText,
                      ),
                      CustomButtonWithGradientBackground(
                        margin: const EdgeInsets.only(top: 23, bottom: 32),
                        height: 54,
                        text: "Login",
                        onPressed: () => _signIn(),
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
                            // context
                            //     .read<AuthBloc>()
                            //     .add(const AuthEventSignInWithGoogle());
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
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.id);
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
      ),
    );
  }

  _signIn() {
    final email = _emailController.text;
    final password = _passwordController.text;
    context.read<AuthBloc>().add(
          AuthEventLogin(
            email,
            password,
          ),
        );
  }

  void _handleLoginExceptions(AuthState state) async {
    if (state is AuthStateLoggedOut) {
      final closeDialog = _closeDialogHandle;
      if (!state.isLoading && closeDialog != null) {
        closeDialog();
        _closeDialogHandle = null;
      }
      if (state.isLoading && closeDialog == null) {
        _closeDialogHandle =
            showLoadingDialog(context: context, message: 'Loading...');
      }
      if (state.exception is UserNotFoundAuthException) {
        setState(() {
          _emailErrorText = "User not found!";
          _passwordErrorText = null;
        });
      } else if (state.exception is WrongPasswordAuthException) {
        setState(() {
          _emailErrorText = _passwordErrorText = "Wrong email or password!";
        });
      } else if (state.exception is GenericAuthException) {
        setState(() {
          _emailErrorText = _passwordErrorText = "Something went wrong!";
        });
      }
    }
  }

  void _navigateToSignUpScreen() {
    context.read<AuthBloc>().add(const AuthEventNeedSignUp());
  }
}
