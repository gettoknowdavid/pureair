part of 'situation_bloc.dart';

abstract class SituationEvent extends Equatable {
  const SituationEvent();
}


class LoadSituation extends SituationEvent {
  
  @override
  List<Object> get props => [];
}

class UpdateSituation extends SituationEvent {
  final SituationEnum situation;

  UpdateSituation(this.situation);
  @override
  List<Object> get props => [situation];
}


class FetchModel extends SituationEvent {
 
  @override
  List<Object> get props => [];
}
