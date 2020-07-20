part of 'search_details_bloc.dart';

abstract class SearchDetailsEvent extends Equatable {
  const SearchDetailsEvent();
}

class FetchSearchDetails extends SearchDetailsEvent {
  final double lat;
  final double lon;

  FetchSearchDetails(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}

class ClearSearchDetails extends SearchDetailsEvent {
  @override
  List<Object> get props => [];
}
