part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchCity extends SearchEvent {
  final String city;

  SearchCity(this.city);

  @override
  List<Object> get props => [city];
}



class RecentCity extends SearchEvent {
  final String city;
  final int uid;

  RecentCity(this.city, this.uid);

  @override
  List<Object> get props => [city, uid];
}

