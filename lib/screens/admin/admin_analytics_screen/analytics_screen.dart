import 'package:bookvies/blocs/user_bloc/user_bloc.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/screens/admin/admin_analytics_screen/widgets/register_chart_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: state.user.imageUrl,
                              height: 54,
                              width: 54,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryTextColor),
                              ),
                              Text("Admin",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.greyTextColor))
                            ],
                          )
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9F0FB),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Register this month",
                                  style: AppStyles.adminHeader),
                              Text("1000", style: AppStyles.adminHeader)
                            ],
                          ),
                        ),
                        const RegisterChartWidget(),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFBF3E1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Review this month",
                                  style: AppStyles.adminHeader),
                              Text("1000", style: AppStyles.adminHeader)
                            ],
                          ),
                        ),
                        const RegisterChartWidget(),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
