import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saved_station.g.dart';

@JsonSerializable(explicitToJson: true)
class SavedStation extends Equatable {
  SavedStation({this.geo});

  final List<double> geo;

  @override
  List<Object> get props => [geo];

  static SavedStation fromJson(Map<String, dynamic> json) =>
      _$SavedStationFromJson(json);
  Map<String, dynamic> toJson() => _$SavedStationToJson(this);
}
