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
  final Aqi model;
  final String message;
  final List<Map<String, String>> pollutants;

  SituationLoaded({
    this.situation,
    this.model,
    this.message,
    this.pollutants,
  });

  @override
  List<Object> get props => [situation, model, message, pollutants];
}

class SituationNotLoaded extends SituationState {
  @override
  List<Object> get props => [];
}
