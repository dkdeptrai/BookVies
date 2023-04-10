part of 'nav_bar_bloc.dart';

@immutable
abstract class NavBarEvent {}

class UpdateIndex extends NavBarEvent {
  final int newIndex;
  UpdateIndex({required this.newIndex});
}
