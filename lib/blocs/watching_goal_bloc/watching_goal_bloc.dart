import 'package:bloc/bloc.dart';
import 'package:bookvies/models/goal_model.dart';
import 'package:bookvies/services/goal_service.dart';
import 'package:equatable/equatable.dart';

part 'watching_goal_event.dart';
part 'watching_goal_state.dart';

class WatchingGoalBloc extends Bloc<WatchingGoalEvent, WatchingGoalState> {
  WatchingGoalBloc() : super(WatchingGoalInitial()) {
    on<LoadWatchingGoal>(_onLoadWatchingGoal);
  }

  _onLoadWatchingGoal(event, emit) async {
    emit(WatchingGoalLoading());

    try {
      final Goal? watchingGoal = await GoalService().getWatchingGoal();
      emit(WatchingGoalLoaded(watchingGoal: watchingGoal));
    } catch (e) {
      emit(WatchingGoalError(message: e.toString()));
    }
  }
}
