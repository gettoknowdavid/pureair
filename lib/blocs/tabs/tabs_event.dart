part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();
}

class UpdateTab extends TabsEvent {
  final Screen screen;

  UpdateTab(this.screen);

  @override
  List<Object> get props => [screen];
}
