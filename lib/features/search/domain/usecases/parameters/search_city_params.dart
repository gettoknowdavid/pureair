import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SearchParams extends Equatable {
  SearchParams({@required this.city});
  final String city;

  @override
  List<Object> get props => [city];
}
