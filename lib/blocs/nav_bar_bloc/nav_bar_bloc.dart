import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarState(currentIndex: 0)) {
    on<UpdateIndex>(_onUpdateIndex);
  }

  _onUpdateIndex(event, emit) {
    emit(NavBarState(currentIndex: event.newIndex));
  }
}
