import 'package:bookvies/blocs/watching_goal_bloc/watching_goal_bloc.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/goal_model.dart';
import 'package:bookvies/services/goal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchingChallengeWidget extends StatefulWidget {
  const WatchingChallengeWidget({super.key});

  @override
  State<WatchingChallengeWidget> createState() =>
      _WatchingChallengeWidgetState();
}

class _WatchingChallengeWidgetState extends State<WatchingChallengeWidget> {
  @override
  void initState() {
    super.initState();
    context.read<WatchingGoalBloc>().add(const LoadWatchingGoal());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width - 2 * AppDimensions.defaultPadding,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: AppDimensions.defaultBorderRadius,
          boxShadow: [AppStyles.tertiaryShadow]),
      child: BlocBuilder<WatchingGoalBloc, WatchingGoalState>(
        builder: (context, state) {
          if (state is WatchingGoalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WatchingGoalLoaded) {
            final watchingGoal = state.watchingGoal;
            if (watchingGoal == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reading challenge",
                      style: AppStyles.smallSemiBoldText),
                  const SizedBox(height: 5),
                  const Text("You haven't had any watching challenge yet",
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => _showWatchingChallengeDialog(context),
                        child: const Text("Start a new challenge")),
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Watching challenge",
                      style: AppStyles.smallSemiBoldText),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value: watchingGoal.finishedAmount /
                                watchingGoal.amount,
                            minHeight: 17,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.mediumBlue),
                            backgroundColor: AppColors.greyTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                          "${watchingGoal.finishedAmount}/${watchingGoal.amount}",
                          style: AppStyles.smallSemiBoldText)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                      "Start date: ${watchingGoal.startDate.day}/${watchingGoal.startDate.month}/${watchingGoal.startDate.year}")
                ],
              );
            }
          } else if (state is WatchingGoalError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  _showWatchingChallengeDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Set a reading challenge"),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter the number of books you want to read"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _addGoal(
                        type: GoalType.watching.name,
                        amount: int.parse(controller.text));
                  },
                  child: const Text("Set"))
            ],
          );
        });
  }

  _addGoal({required String type, required int amount}) async {
    final Goal goal = Goal(
        id: "",
        type: type,
        startDate: DateTime.now(),
        status: GoalStatus.inProgress.name,
        amount: amount,
        finishedAmount: 0);

    await GoalService().addGoal(goal: goal);
    if (!mounted) {
      return;
    }
    context.read<WatchingGoalBloc>().add(const LoadWatchingGoal());
  }
}
