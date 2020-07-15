part of 'tabs_bloc.dart';

class TabsState extends Equatable {
  final ScreenWidget widget;

  TabsState(this.widget);

  @override
  List<Object> get props => [widget];
}
