part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class UpdateBottomNav extends BottomNavEvent {
  final ScreenEnum screen;

  UpdateBottomNav(this.screen);

  @override
  List<Object> get props => [screen];
}
