import 'package:bookvies/blocs/reading_goal_bloc/reading_goal_bloc.dart';
import 'package:bookvies/constant/colors.dart';
import 'package:bookvies/constant/constants.dart';
import 'package:bookvies/constant/dimensions..dart';
import 'package:bookvies/constant/styles.dart';
import 'package:bookvies/models/goal_model.dart';
import 'package:bookvies/services/goal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingChallengeWidget extends StatefulWidget {
  const ReadingChallengeWidget({super.key});

  @override
  State<ReadingChallengeWidget> createState() => _ReadingChallengeWidgetState();
}

class _ReadingChallengeWidgetState extends State<ReadingChallengeWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ReadingGoalBloc>().add(const LoadReadingGoal());
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
      child: BlocBuilder<ReadingGoalBloc, ReadingGoalState>(
        builder: (context, state) {
          if (state is ReadingGoalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReadingGoalLoaded) {
            final readingGoal = state.readingGoal;
            if (readingGoal == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reading challenge",
                      style: AppStyles.smallSemiBoldText),
                  const SizedBox(height: 5),
                  const Text("You haven't had any reading challenge yet",
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => _showReadingChallengeDialog(context),
                        child: const Text("Start a new challenge")),
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reading challenge",
                      style: AppStyles.smallSemiBoldText),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value:
                                readingGoal.finishedAmount / readingGoal.amount,
                            minHeight: 17,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.mediumBlue),
                            backgroundColor: AppColors.greyTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                          "${readingGoal.finishedAmount}/${readingGoal.amount}",
                          style: AppStyles.smallSemiBoldText)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                      "Start date: ${readingGoal.startDate.day}/${readingGoal.startDate.month}/${readingGoal.startDate.year}")
                ],
              );
            }
          } else if (state is ReadingGoalError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  _showReadingChallengeDialog(BuildContext context) {
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
                        type: GoalType.reading.name,
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
    context.read<ReadingGoalBloc>().add(const LoadReadingGoal());
  }
}
