import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AqiParams extends Equatable {
  AqiParams({@required this.lat, @required this.lon});

  final String lat;
  final String lon;

  @override
  List<Object> get props => [lat, lon];
}
