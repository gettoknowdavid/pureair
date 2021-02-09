part of 'search_details_bloc.dart';

abstract class SearchDetailsEvent extends Equatable {
  const SearchDetailsEvent();

  @override
  List<Object> get props => [];
}
class GetSearchDetailsEvent extends SearchDetailsEvent {
  GetSearchDetailsEvent({@required this.lat, @required this.lon});
  final double lat;
  final double lon;

  @override
  List<Object> get props => [lat, lon];
}
