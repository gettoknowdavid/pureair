part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchSearch extends SearchEvent {
  final String city;

  FetchSearch(this.city);

  @override
  List<Object> get props => [];
}

class LoadSearch extends SearchEvent {}

class LoadStationData extends SearchEvent {}

class AddStation extends SearchEvent {
  final SearchData data;

  AddStation(this.data);

  @override
  List<Object> get props => [data];
}
