part of 'reading_goal_bloc.dart';

abstract class ReadingGoalEvent extends Equatable {
  const ReadingGoalEvent();

  @override
  List<Object> get props => [];
}

class LoadReadingGoal extends ReadingGoalEvent {
  const LoadReadingGoal();
}
