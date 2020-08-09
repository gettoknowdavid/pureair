part of 'search_details_bloc.dart';

abstract class SearchDetailsState extends Equatable {
  const SearchDetailsState();
}

class SearchDetailsLoading extends SearchDetailsState {
  @override
  List<Object> get props => [];
}

class SearchDetailsLoaded extends SearchDetailsState {
  final Aqi model;
  final SituationEnum situation;
  final String message;
  final List<Map<String, String>> pollutants;

  SearchDetailsLoaded(
      this.model, this.situation, this.message, this.pollutants);

  @override
  List<Object> get props => [model, situation, message, pollutants];
}

class SearchDetailsNotLoaded extends SearchDetailsState {
  @override
  List<Object> get props => [];
}
