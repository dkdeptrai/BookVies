part of 'watching_goal_bloc.dart';

abstract class WatchingGoalEvent extends Equatable {
  const WatchingGoalEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchingGoal extends WatchingGoalEvent {
  const LoadWatchingGoal();
}
