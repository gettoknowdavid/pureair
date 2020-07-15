import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pureair/src/model/search_model/search_data.dart';

part 'search.g.dart';

@JsonSerializable(explicitToJson: true)
class Search extends Equatable {
  Search({this.stations});

  final List<SearchData> stations;

  @override
  List<Object> get props => [stations];

  static Search fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
