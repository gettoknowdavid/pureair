import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'saved_station.g.dart';

@JsonSerializable(explicitToJson: true)
class SavedStation extends Equatable {
  SavedStation({String id, this.geo}) : id = id ?? Uuid().v4();

  final String id;
  final List<double> geo;

  @override
  List<Object> get props => [id, geo];

  static SavedStation fromJson(Map<String, dynamic> json) =>
      _$SavedStationFromJson(json);
  Map<String, dynamic> toJson() => _$SavedStationToJson(this);
}
