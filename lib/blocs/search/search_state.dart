part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchAqi searchAqi;

  SearchLoaded(this.searchAqi);

  @override
  List<Object> get props => [searchAqi];
}

class SearchNotLoaded extends SearchState {}
