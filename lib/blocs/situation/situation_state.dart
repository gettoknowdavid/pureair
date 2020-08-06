part of 'situation_bloc.dart';

abstract class SituationState extends Equatable {
  const SituationState();
}

class SituationLoading extends SituationState {
  @override
  List<Object> get props => [];
}

class SituationLoaded extends SituationState {
  final SituationEnum situation;
  final Favourites favourites;

  SituationLoaded(this.situation, this.favourites);

  @override
  List<Object> get props => [situation, favourites];
}

class SituationNotLoaded extends SituationState {
  @override
  List<Object> get props => [];
}
