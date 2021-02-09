import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/search_aqi.dart';
import 'search_data_model.dart';

part 'generated/search_aqi_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchAqiModel extends SearchAqi {
  SearchAqiModel({
    String status,
    List<SearchDataModel> data,
  }) : super(status: status, data: data);

  @override
  List<Object> get props => [status, data];

  static SearchAqiModel fromJson(Map<String, dynamic> json) =>
      _$SearchAqiModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchAqiModelToJson(this);
}
