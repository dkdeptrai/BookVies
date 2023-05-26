import 'package:bookvies/common_widgets/custom_button_with_gradient_background.dart';
import 'package:bookvies/constant/assets.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDescriptionWidget extends StatelessWidget {
  final UserModel user;
  const UserDescriptionWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 254),
      child: Stack(
        children: [
          Positioned(
            top: 40, // Move the container down by 40
            left: 0,
            right: 0,
            child: Container(
              height: 214,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: AppColors.secondaryColor,
                boxShadow: [AppStyles.secondaryShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: AppStyles.sectionHeaderText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                        user.description,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: user.id == currentUser!.uid
                          ? Row(
                              children: [
                                Expanded(
                                  child: CustomButtonWithGradientBackground(
                                      margin: const EdgeInsets.only(right: 15),
                                      height: 40,
                                      width: 247,
                                      text: 'Follow',
                                      onPressed: () {}),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(AppAssets.icSend))
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
