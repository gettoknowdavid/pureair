part of 'situation_bloc.dart';

abstract class SituationEvent extends Equatable {
  const SituationEvent();
}

class UpdateSituation extends SituationEvent {
  final SituationEnum situation;

  UpdateSituation(this.situation);

  @override
  List<Object> get props => [situation];
}

class UpdateFavourites extends SituationEvent {
  final Favourites favourites;

  UpdateFavourites(this.favourites);

  @override
  List<Object> get props => [favourites];
}
