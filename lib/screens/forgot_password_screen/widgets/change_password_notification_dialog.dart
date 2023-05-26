import 'package:bookvies/blocs/auth_bloc/auth_bloc.dart';
import 'package:bookvies/blocs/auth_bloc/auth_event.dart';
import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordNotificationDialog extends StatelessWidget {
  const ChangePasswordNotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 356,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.imgEmailSent),
            Container(
              margin: const EdgeInsets.only(top: 27),
              width: double.infinity,
              child: const Text(
                "We have sent you an password reset email.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              "Please check your inbox!",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryTextColor,
              ),
            ),
            CustomButtonWithGradientBackground(
                margin: const EdgeInsets.only(top: 18),
                height: 35,
                width: 135,
                text: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                }),
            Container(
              margin: const EdgeInsets.only(top: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 12, color: AppColors.greyTextColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
