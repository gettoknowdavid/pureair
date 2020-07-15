part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchResult extends SearchState {
  final List<SearchData> stations;

  SearchResult(this.stations);

  @override
  List<Object> get props => [stations];
}

class StoredStations extends SearchState {
  final List<SearchData> stations;

  StoredStations(this.stations);

  @override
  List<Object> get props => [stations];
}

class SearchNotLoaded extends SearchState {}

class SearchNotFound extends SearchState {
  final String city;

  SearchNotFound(this.city);

  @override
  List<Object> get props => [city];
}
