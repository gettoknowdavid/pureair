import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DetailsParams extends Equatable {
  DetailsParams({@required this.lat, @required this.lon});
  final double lat;
  final double lon;

  @override
  List<Object> get props => [lat, lon];
}
