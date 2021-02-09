part of 'search_aqi_bloc.dart';

abstract class SearchAqiState extends Equatable {
  const SearchAqiState();

  @override
  List<Object> get props => [];
}

class SearchAqiEmpty extends SearchAqiState {}

class SearchAqiLoading extends SearchAqiState {}

class SearchAqiLoaded extends SearchAqiState {
  SearchAqiLoaded({@required this.searchAqi});
  final SearchAqi searchAqi;

  @override
  List<Object> get props => [searchAqi];
}

class SearchAqiError extends SearchAqiState {
  SearchAqiError({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
