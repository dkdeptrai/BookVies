import 'package:bloc/bloc.dart';
import 'package:bookvies/models/goal_model.dart';
import 'package:bookvies/services/goal_service.dart';
import 'package:equatable/equatable.dart';

part 'reading_goal_event.dart';
part 'reading_goal_state.dart';

class ReadingGoalBloc extends Bloc<ReadingGoalEvent, ReadingGoalState> {
  ReadingGoalBloc() : super(ReadingGoalInitial()) {
    on<LoadReadingGoal>(_onLoadReadingGoal);
  }

  _onLoadReadingGoal(event, emit) async {
    emit(ReadingGoalLoading());

    try {
      final Goal? readingGoal = await GoalService().getReadingGoal();
      emit(ReadingGoalLoaded(readingGoal: readingGoal));
    } catch (e) {
      emit(ReadingGoalError(message: e.toString()));
    }
  }
}
