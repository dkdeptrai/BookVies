import 'package:bloc/bloc.dart';
import 'package:bookvies/models/user_model.dart';
import 'package:bookvies/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  _onLoadUser(event, emit) async {
    emit(UserLoading());
    try {
      final user = await UserService().loadUserData();
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(const UserLoadFailed(message: "User not found"));
      }
    } catch (error) {
      print("Load user error: $error");
    }
  }
}
