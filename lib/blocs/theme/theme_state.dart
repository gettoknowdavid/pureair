part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  @override
  List<Object> get props => [];
}

class ThemeLoaded extends ThemeState {
  final ThemeData theme;

  ThemeLoaded({@required this.theme});

  @override
  List<Object> get props => [theme];
}

class ThemeLoading extends ThemeState {}
