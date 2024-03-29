import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'search_data.dart';

part 'generated/search_aqi.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchAqi extends Equatable {
  SearchAqi({
    this.status,
    this.data,
  });

  final String status;
  final List<SearchData> data;

  @override
  List<Object> get props => [status, data];

  static SearchAqi fromJson(Map<String, dynamic> json) =>
      _$SearchAqiFromJson(json);
  Map<String, dynamic> toJson() => _$SearchAqiToJson(this);
}
