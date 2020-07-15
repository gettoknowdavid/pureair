part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class LoadTheme extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final ThemeEnum theme;

  ChangeTheme(this.theme);

  @override
  String toString() => 'ThemeChanged';

  @override
  List<Object> get props => [theme];
}
