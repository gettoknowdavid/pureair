part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  BottomNavState(this.widget);

  final ScreenWidget widget;

  @override
  List<Object> get props => [widget];
}
