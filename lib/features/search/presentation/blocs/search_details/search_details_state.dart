part of 'search_details_bloc.dart';

abstract class SearchDetailsState extends Equatable {
  const SearchDetailsState();

  @override
  List<Object> get props => [];
}

class SearchDetailsEmpty extends SearchDetailsState {}

class SearchDetailsLoading extends SearchDetailsState {}

class SearchDetailsLoaded extends SearchDetailsState {
  SearchDetailsLoaded({@required this.data});
  final AqiByCondition data;

  @override
  List<Object> get props => [data];
}

class SearchDetailsError extends SearchDetailsState {
  SearchDetailsError({@required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
