part of 'search_aqi_bloc.dart';

abstract class SearchAqiEvent extends Equatable {
  const SearchAqiEvent();

  @override
  List<Object> get props => [];
}

class SearchCityEvent extends SearchAqiEvent {
  SearchCityEvent({@required this.city});
  final String city;

  @override
  List<Object> get props => [city];
}
