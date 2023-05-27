part of 'reading_goal_bloc.dart';

abstract class ReadingGoalState extends Equatable {
  const ReadingGoalState();

  @override
  List<Object> get props => [];
}

class ReadingGoalInitial extends ReadingGoalState {}

class ReadingGoalLoading extends ReadingGoalState {}

class ReadingGoalLoaded extends ReadingGoalState {
  final Goal? readingGoal;

  const ReadingGoalLoaded({required this.readingGoal});
}

class ReadingGoalError extends ReadingGoalState {
  final String message;

  const ReadingGoalError({required this.message});
}
