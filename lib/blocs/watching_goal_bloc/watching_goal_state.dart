part of 'watching_goal_bloc.dart';

abstract class WatchingGoalState extends Equatable {
  const WatchingGoalState();

  @override
  List<Object> get props => [];
}

class WatchingGoalInitial extends WatchingGoalState {}

class WatchingGoalLoading extends WatchingGoalState {}

class WatchingGoalLoaded extends WatchingGoalState {
  final Goal? watchingGoal;

  const WatchingGoalLoaded({required this.watchingGoal});
}

class WatchingGoalError extends WatchingGoalState {
  final String message;

  const WatchingGoalError({required this.message});
}
