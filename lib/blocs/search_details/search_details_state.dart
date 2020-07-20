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

  SearchDetailsLoaded(this.model);
  @override
  List<Object> get props => [model];
}

class SearchDetailsNotLoaded extends SearchDetailsState {
  @override
  List<Object> get props => [];
}
